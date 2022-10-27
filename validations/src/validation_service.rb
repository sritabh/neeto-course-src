require 'yaml'
require_relative './config_rules/course_name_present'
require_relative './config_rules/course_slug_present'
require_relative './config_rules/course_published_present'
require_relative './config_rules/course_image_exists'
require_relative './config_rules/course_slugs_unique'
require_relative './config_rules/courses_metadata_matches_course_directories'

module Src
  class ValidationService
    attr_reader :app_root, :course_metadata_config, :course_directories, :images_path, :databases_path

    def initialize
    end

    def process
      puts "Gathering config".blue
      set_directories
      set_course_metadata_config
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

    def set_course_metadata_config
      @course_metadata_config = YAML.load_file(File.join(app_root, "courses.yml"))
    end

    def set_course_directories
      @course_directories = Dir[File.join(app_root, "courses", "*")].select { |f| File.directory? f }
    end

    def validate_course_data
      course_metadata_config.each_with_index do |course_data, course_index|
        validate_course_name_present(course_data, course_index)
        validate_course_slug_present(course_data, course_index)
        validate_course_published_present(course_data, course_index)
        validate_course_logo_exists_if_specified(course_data, course_index)
        validate_course_home_logo_exists_if_specified(course_data, course_index)
      end
      validate_uniqueness_of_course_slugs
      validate_course_metadata_config_matches_course_directories
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

    def validate_course_logo_exists_if_specified(course_data, course_index)
      Src::ConfigRules::CourseImageExists.new(course_data, course_index, "logo", images_path).process
    end

    def validate_course_home_logo_exists_if_specified(course_data, course_index)
      Src::ConfigRules::CourseImageExists.new(course_data, course_index, "home_logo", images_path).process
    end

    def validate_uniqueness_of_course_slugs
      Src::ConfigRules::CourseSlugsUnique.new(course_metadata_config).process
    end

    def validate_course_metadata_config_matches_course_directories
      Src::ConfigRules::CoursesMetadataMatchesCourseDirectories.new(course_metadata_config, course_directories).process
    end
  end
end
