require 'yaml'
require_relative './config_rules/course_name_present'
require_relative './config_rules/course_slug_present'
require_relative './config_rules/course_published_present'
require_relative './config_rules/course_image_exists'
require_relative './config_rules/chapter_name_present'
require_relative './config_rules/chapter_slug_present'
require_relative './config_rules/chapter_slugs_unique'
require_relative './config_rules/chapters_data_matches_chapter_directories'
require_relative './config_rules/page_title_present'
require_relative './config_rules/page_slug_present'
require_relative './config_rules/page_type_present'
require_relative './config_rules/page_slugs_unique'
require_relative './config_rules/pages_data_matches_page_files'
require_relative './config_rules/page_codeblock_tags_valid'
require_relative './config_rules/page_image_tags_valid'

module Src
  class ValidationService
    attr_reader :app_root, :course_metadata_config, :course_directories, :images_path, :databases_path

    def initialize
    end

    def process
      puts "Gathering config".blue
      set_directories
      set_course_directories
      puts "Validating config".blue
      validate_course_data
      puts "Config is valid".green
    rescue StandardError => e
      puts "Error: #{e.message}".red
      e.backtrace.map do |line|
        puts line.red
      end
      raise "Validation failed"
    end

    private

    def set_directories
      @app_root = File.expand_path("../../", __dir__)
      assets_path = File.join(app_root, "assets")
      @images_path = File.join(assets_path, "images")
      @databases_path = File.join(assets_path, "databases")
    end


    def set_course_directories
      @course_directories = Dir[File.join(app_root, "courses", "*")].select { |f| File.directory? f }
    end

    def validate_course_data

      course_directories.each_with_index do |course_directory, course_index|
        ###################### course_metadata_validation ######################
        course_data = load_course_data(course_directory)
        course_assets_config = load_course_assets_config(course_directory)
        validate_course_name_present(course_data, course_index)
        validate_course_slug_present(course_data, course_index)
        validate_course_published_present(course_data, course_index)
        validate_course_logo_exists_if_specified(course_data, course_index, course_directory, course_assets_config) if course_data["logo"]
        validate_course_home_logo_exists_if_specified(course_data, course_index, course_directory, course_assets_config) if course_data["home_logo"]

        ##################### chapters_config_validation ######################
        chapters_config = load_chapters_config(course_directory)
        chapter_directories = Dir[File.join(course_directory, "chapters", "*")].select { |f| File.directory? f }
        course_base_directory_name = File.basename(course_directory)

        validate_uniqueness_of_chapter_slugs(chapters_config, course_base_directory_name)
        chapters_config.each_with_index do |chapter_data, chapter_index|
          validate_chapter_name_present(chapter_data, chapter_index, course_base_directory_name)
          validate_chapter_slug_present(chapter_data, chapter_index, course_base_directory_name)
        end
        validate_chapters_data_matches_chapter_directories(chapters_config, chapter_directories, course_base_directory_name)

        ##################### pages_config_validation ######################
        chapter_directories.each do |chapter_directory|
          pages_config = load_pages_config(chapter_directory, course_base_directory_name)
          page_files = Dir[File.join(chapter_directory, "pages", "*.md")].select { |f| File.file? f }
          chapter_base_directory_name = File.basename(chapter_directory)

          validate_uniqueness_of_page_slugs(pages_config, course_base_directory_name, chapter_base_directory_name)
          pages_config.each_with_index do |page_data, page_index|
            validate_page_title_present(page_data, page_index, course_base_directory_name, chapter_base_directory_name)
            validate_page_slug_present(page_data, page_index, course_base_directory_name, chapter_base_directory_name)
            validate_page_type_present(page_data, page_index, course_base_directory_name, chapter_base_directory_name)
          end
          validate_pages_data_matches_page_files(pages_config, page_files, course_base_directory_name, chapter_base_directory_name)

          page_files.each do |page_file|
            validate_page_codeblock_tags(page_file, course_base_directory_name, chapter_base_directory_name, course_assets_config)
            validate_page_image_tags(page_file, course_base_directory_name, chapter_base_directory_name, course_assets_config)
          end
        end
      end
    end

    def load_course_data(course_directory)
      course_metadata_path = File.join(course_directory, "metadata.yml")
      course_base_directory_name = File.basename(course_directory)

      if !File.exist?(course_metadata_path)
        raise "metadata.yml does not exist in #{course_base_directory_name}"
      end

      YAML.load_file(course_metadata_path)
    rescue Psych::SyntaxError => e
      raise "Error parsing metadata.yml in #{course_base_directory_name}: #{e}"
    end

    def load_course_assets_config(course_directory)
      course_assets_path = File.join(course_directory, "assets.yml")
      course_base_directory_name = File.basename(course_directory)

      if !File.exist?(course_assets_path)
        raise "assets.yml does not exist in #{course_base_directory_name}"
      end

      YAML.load_file(course_assets_path)
    rescue Psych::SyntaxError => e
      raise "Error parsing assets.yml in #{course_base_directory_name}: #{e}"
    end

    def load_chapters_config(course_directory)
      chapters_config_path = File.join(course_directory, "chapters.yml")
      course_base_directory_name = File.basename(course_directory)

      if !File.exist?(chapters_config_path)
        raise "chapters.yml does not exist in #{course_base_directory_name}"
      end

      YAML.load_file(chapters_config_path)
    rescue Psych::SyntaxError => e
      raise "Error parsing chapters.yml in #{course_base_directory_name}: #{e}"
    end

    def load_pages_config(chapter_directory, course_base_directory_name)
      pages_config_path = File.join(chapter_directory, "pages.yml")
      chapter_base_directory_name = File.basename(chapter_directory)

      if !File.exist?(pages_config_path)
        raise "pages.yml does not exist in #{chapter_base_directory_name} in #{course_base_directory_name}"
      end

      YAML.load_file(pages_config_path)
    rescue Psych::SyntaxError => e
      raise "Error parsing pages.yml in #{chapter_base_directory_name} in #{course_base_directory_name}: #{e}"
    end

    def validate_course_name_present(course_data, course_index)
      Src::ConfigRules::CourseNamePresent.new(course_data, course_index).process
    end

    def validate_course_slug_present(course_data, course_index)
      Src::ConfigRules::CourseSlugPresent.new(course_data, course_index).process
    end

    def validate_course_published_present(course_data, course_index)
      Src::ConfigRules::CoursePublishedPresent.new(course_data, course_index).process
    end

    def validate_course_logo_exists_if_specified(course_data, course_index, course_directory, course_assets_config)
      Src::ConfigRules::CourseImageExists.new(course_data, course_index, "logo", images_path, course_directory, course_assets_config).process
    end

    def validate_course_home_logo_exists_if_specified(course_data, course_index, course_directory, course_assets_config)
      Src::ConfigRules::CourseImageExists.new(course_data, course_index, "home_logo", images_path, course_directory, course_assets_config).process
    end

    def validate_chapter_name_present(chapter_data, chapter_index, course_base_directory_name)
      Src::ConfigRules::ChapterNamePresent.new(chapter_data, chapter_index, course_base_directory_name).process
    end

    def validate_chapter_slug_present(chapter_data, chapter_index, course_base_directory_name)
      Src::ConfigRules::ChapterSlugPresent.new(chapter_data, chapter_index, course_base_directory_name).process
    end

    def validate_uniqueness_of_chapter_slugs(chapters_data, course_base_directory_name)
      Src::ConfigRules::ChapterSlugsUnique.new(chapters_data, course_base_directory_name).process
    end

    def validate_chapters_data_matches_chapter_directories(chapters_data, chapter_directories, course_base_directory_name)
      Src::ConfigRules::ChaptersDataMatchesChapterDirectories.new(chapters_data, chapter_directories, course_base_directory_name).process
    end

    def validate_page_title_present(page_data, page_index, course_base_directory_name, chapter_base_directory_name)
      Src::ConfigRules::PageTitlePresent.new(page_data, page_index, course_base_directory_name, chapter_base_directory_name).process
    end

    def validate_page_slug_present(page_data, page_index, course_base_directory_name, chapter_base_directory_name)
      Src::ConfigRules::PageSlugPresent.new(page_data, page_index, course_base_directory_name, chapter_base_directory_name).process
    end

    def validate_page_type_present(page_data, page_index, course_base_directory_name, chapter_base_directory_name)
      Src::ConfigRules::PageTypePresent.new(page_data, page_index, course_base_directory_name, chapter_base_directory_name).process
    end

    def validate_uniqueness_of_page_slugs(pages_data, course_base_directory_name, chapter_base_directory_name)
      Src::ConfigRules::PageSlugsUnique.new(pages_data, course_base_directory_name, chapter_base_directory_name).process
    end

    def validate_pages_data_matches_page_files(pages_data, page_files, course_base_directory_name, chapter_base_directory_name)
      Src::ConfigRules::PagesDataMatchesPageFiles.new(pages_data, page_files, course_base_directory_name, chapter_base_directory_name).process
    end

    def validate_page_codeblock_tags(page_file, course_base_directory_name, chapter_base_directory_name, course_assets_config)
      Src::ConfigRules::PageCodeblockTagsValid.new(page_file, course_base_directory_name, chapter_base_directory_name, databases_path, course_assets_config).process
    end

    def validate_page_image_tags(page_file, course_base_directory_name, chapter_base_directory_name, course_assets_config)
      Src::ConfigRules::PageImageTagsValid.new(page_file, course_base_directory_name, chapter_base_directory_name, images_path, course_assets_config).process
    end
  end
end
