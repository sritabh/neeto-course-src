require_relative './base'

module Src
  module ConfigRules
    class CoursePublishedPresent < Src::ConfigRules::Base
      attr_reader :course_data, :course_index

      def initialize(course_data, course_index)
        @course_data = course_data
        @course_index = course_index
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true
        if course_data["published"]&.nil? || course_data["published"].to_s.empty?
          @error_message = "Course published is missing in courses.yml at index #{course_index}"
          return false
        end
        if !([true, false].include? course_data["published"])
          @error_message = "Course published is not a boolean in courses.yml at index #{course_index}"
          return false
        end
        rule_verified
      end
    end
  end
end
