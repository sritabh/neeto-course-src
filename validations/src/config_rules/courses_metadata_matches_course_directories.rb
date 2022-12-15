require_relative './base'

module Src
  module ConfigRules
    class CoursesMetadataMatchesCourseDirectories < Src::ConfigRules::Base
      attr_reader :course_data, :course_directory

      def initialize(course_data, course_directory)
        @course_data = course_data
        @course_directory = course_directory
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true

        course_slugs_as_in_metadata = course_data["slug"]
        course_slugs_as_in_course_directory = File.basename(course_directory)


        if course_slugs_as_in_metadata != course_slugs_as_in_course_directory
          @error_message = "Course directory name #{course_slugs_as_in_course_directory} and slug #{course_slugs_as_in_metadata} mentioned in the #{File.join(course_directory, "metadata.yml")} are not the same"
          return false
        end

        return rule_verified
      end
    end
  end
end
