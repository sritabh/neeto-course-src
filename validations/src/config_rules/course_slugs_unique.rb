require_relative './base'

module Src
  module ConfigRules
    class CourseSlugsUnique < Src::ConfigRules::Base
      attr_reader :course_directories

      def initialize(course_directories)
        @course_directories = course_directories
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true

        all_course_slugs = load_all_course_slugs
        unique_course_slugs = all_course_slugs.uniq

        if all_course_slugs.length != unique_course_slugs.length
          repeating_course_slugs = unique_course_slugs.select { |slug| all_course_slugs.count(slug) > 1 }.uniq
          @error_message = "Course slugs are not unique in courses.yml. Slugs [#{repeating_course_slugs.join(", ")}] are repeated."
          return false
        end

        return rule_verified
      end

      private

      def load_all_course_slugs
        course_directories.map do |course_directory|
          course_metadata_path = File.join(course_directory, "metadata.yml")
          course_base_directory_name = File.basename(course_directory)
    
          if !File.exist?(course_metadata_path)
            raise "metadata.yml does not exist in #{course_base_directory_name}"
          end
          metadata = YAML.load_file(course_metadata_path)
          metadata["slug"]
        rescue Psych::SyntaxError => e
          raise "Error parsing metadata.yml in #{course_base_directory_name}: #{e}"
        end
      end
    end
  end
end
