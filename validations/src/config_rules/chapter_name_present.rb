require_relative './base'

module Src
  module ConfigRules
    class ChapterNamePresent < Src::ConfigRules::Base
      attr_reader :chapter_data, :chapter_index, :course_base_directory_name

      def initialize(chapter_data, chapter_index, course_base_directory_name)
        @chapter_data = chapter_data
        @chapter_index = chapter_index
        @course_base_directory_name = course_base_directory_name
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true
        if chapter_data["name"]&.nil? || chapter_data["name"].to_s.empty?
          @error_message = "Chapter name is missing in chapters.yml at index #{chapter_index} in course #{course_base_directory_name}."
          return false
        end
        if !chapter_data["name"]&.is_a?(String)
          @error_message = "Chapter name is not a string in chapters.yml at index #{chapter_index} in course #{course_base_directory_name}."
          return false
        end
        rule_verified
      end
    end
  end
end
