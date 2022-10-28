require_relative './base'

module Src
  module ConfigRules
    class PageTypePresent < Src::ConfigRules::Base
      attr_reader :page_data, :page_index, :course_base_directory_name, :chapter_base_directory_name

      def initialize(page_data, page_index, course_base_directory_name, chapter_base_directory_name)
        @page_data = page_data
        @page_index = page_index
        @course_base_directory_name = course_base_directory_name
        @chapter_base_directory_name = chapter_base_directory_name
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true
        if page_data["page_type"]&.nil? || page_data["page_type"].to_s.empty?
          @error_message = "Page page_type is missing in pages.yml at index #{page_index} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name}."
          return false
        end
        if !page_data["page_type"]&.is_a?(String)
          @error_message = "Page page_type is not a string in pages.yml at index #{page_index} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name}."
          return false
        end
        if !["lesson", "exercise", "assessment"].include?(page_data["page_type"])
          @error_message = "Page page_type is not one of [lesson, exercise, assessment] in pages.yml at index #{page_index} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name}."
          return false
        end
        rule_verified
      end
    end
  end
end
