require_relative './base'

module Src
  module ConfigRules
    class CourseSlugsUnique < Src::ConfigRules::Base
      attr_reader :courses_data

      def initialize(courses_data)
        @courses_data = courses_data
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true

        all_course_slugs = courses_data.map { |course| course["slug"] }
        unique_course_slugs = all_course_slugs.uniq

        if all_course_slugs.length != unique_course_slugs.length
          repeating_course_slugs = unique_course_slugs.select { |slug| all_course_slugs.count(slug) > 1 }.uniq
          @error_message = "Course slugs are not unique in courses.yml. Slugs [#{repeating_course_slugs.join(", ")}] are repeated."
          return false
        end

        return rule_verified
      end
    end
  end
end
