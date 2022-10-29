require_relative './base'

module Src
  module ConfigRules
    class CourseSlugPresent < Src::ConfigRules::Base
      attr_reader :course_data, :course_index

      def initialize(course_data, course_index)
        @course_data = course_data
        @course_index = course_index
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true
        if course_data["slug"]&.nil? || course_data["slug"].to_s.empty?
          @error_message = "Course slug is missing in courses.yml at index #{course_index}"
          return false
        end
        if !course_data["slug"]&.is_a?(String)
          @error_message = "Course slug is not a string in courses.yml at index #{course_index}"
          return false
        end
        if (course_data["slug"].to_s =~ /^[a-z0-9]+(?:-[a-z0-9]+)*$/).nil?
          @error_message = "Course slug is not a valid slug in courses.yml at index #{course_index}"
          return false
        end
        return rule_verified
      end
    end
  end
end
