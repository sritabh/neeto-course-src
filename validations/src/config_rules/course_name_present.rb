require_relative './base'

module Src
  module ConfigRules
    class CourseNamePresent < Src::ConfigRules::Base
      attr_reader :course_data, :course_index

      def initialize(course_data, course_index)
        @course_data = course_data
        @course_index = course_index
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true
        if course_data["name"]&.nil? || course_data["name"].to_s.empty?
          @error_message = "Course name is missing in courses.yml at index #{course_index}"
          return false
        end
        if !course_data["name"]&.is_a?(String)
          @error_message = "Course name is not a string in courses.yml at index #{course_index}"
          return false
        end
        rule_verified
      end
    end
  end
end
