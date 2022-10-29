require_relative './base'

module Src
  module ConfigRules
    class ChapterSlugsUnique < Src::ConfigRules::Base
      attr_reader :chapters_data, :course_base_directory_name

      def initialize(chapters_data, course_base_directory_name)
        @chapters_data = chapters_data
        @course_base_directory_name = course_base_directory_name
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true

        all_chapter_slugs = chapters_data.map { |chapter| chapter["slug"] }
        unique_chapter_slugs = all_chapter_slugs.uniq

        if all_chapter_slugs.length != unique_chapter_slugs.length
          repeating_chapter_slugs = unique_chapter_slugs.select { |slug| all_chapter_slugs.count(slug) > 1 }.uniq
          @error_message = "Chapter slugs are not unique in chapters.yml in course #{course_base_directory_name}. Slugs [#{repeating_chapter_slugs.join(", ")}] are repeated."
          return false
        end

        return rule_verified
      end
    end
  end
end
