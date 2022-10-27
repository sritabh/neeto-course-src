require_relative './base'

module Src
  module ConfigRules
    class CoursesMetadataMatchesCourseDirectories < Src::ConfigRules::Base
      attr_reader :courses_data, :course_directories

      def initialize(courses_data, course_directories)
        @courses_data = courses_data
        @course_directories = course_directories
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true

        sorted_course_directories = course_directories.sort
        course_slugs_as_in_metadata = courses_data.map { |course| course["slug"] }
        course_slugs_as_in_course_directories = sorted_course_directories.map { |course_directory| File.basename(course_directory).split("-", 2)[1] }

        if course_slugs_as_in_metadata != course_slugs_as_in_course_directories
          missing_courses_in_directories = course_slugs_as_in_metadata - course_slugs_as_in_course_directories
          missing_courses_in_metadata = course_slugs_as_in_course_directories - course_slugs_as_in_metadata

          if missing_courses_in_directories.length > 0
            @error_message = "Course directories are missing for courses [#{missing_courses_in_directories.join(", ")}] specified in courses.yml."
          elsif missing_courses_in_metadata.length > 0
            @error_message = "Course data in courses.yml is missing for courses [#{missing_courses_in_metadata.join(", ")}] specified in courses directory."
          else
            course_slugs_mismatched_in_order = course_slugs_as_in_metadata.select{ |slug, index| course_slugs_as_in_course_directories.index(slug) != index }
            @error_message = "Course directories are not in the same order as courses in courses.yml for the follwing courses [#{course_slugs_mismatched_in_order.join(", ")}]"
          end
          return false
        end

        return rule_verified
      end
    end
  end
end
