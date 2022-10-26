require 'yaml'
require_relative './config_rules/course_name_present'
require_relative './config_rules/course_slug_present'
require_relative './config_rules/course_published_present'
require_relative './config_rules/course_slugs_unique'

module Src
  class ValidationService
    attr_reader :app_root, :course_metadata_config, :course_directories

    def initialize
    end

    def process
      puts "Gathering config".blue
      set_app_root
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

    def set_app_root
      @app_root = File.expand_path("../../", __dir__)
    end

    def set_course_metadata_config
      @course_metadata_config = YAML.load_file(File.join(app_root, "courses.yml"))
    end

    def set_course_directories
      @course_directories = Dir[File.join(app_root, "courses", "*")]
    end

    def validate_course_data
      course_metadata_config.each_with_index do |course_data, course_index|
        validate_course_name_present(course_data, course_index)
        validate_course_slug_present(course_data, course_index)
        validate_course_published_present(course_data, course_index)
      end
      validate_uniqueness_of_course_slugs(course_metadata_config)
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

    def validate_uniqueness_of_course_slugs(courses_data)
      Src::ConfigRules::CourseSlugsUnique.new(courses_data).process
    end
  end
end
