require_relative './base'

module Src
  module ConfigRules
    class PageSlugsUnique < Src::ConfigRules::Base
      attr_reader :pages_data, :course_base_directory_name, :chapter_base_directory_name

      def initialize(pages_data, course_base_directory_name, chapter_base_directory_name)
        @pages_data = pages_data
        @course_base_directory_name = course_base_directory_name
        @chapter_base_directory_name = chapter_base_directory_name
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true

        all_page_slugs = pages_data.map { |page| page["slug"] }
        unique_page_slugs = all_page_slugs.uniq

        if all_page_slugs.length != unique_page_slugs.length
          repeating_page_slugs = unique_page_slugs.select { |slug| all_page_slugs.count(slug) > 1 }.uniq
          @error_message = "Page slugs are not unique in pages.yml in chapter #{chapter_base_directory_name} in course #{course_base_directory_name}. Slugs [#{repeating_page_slugs.join(", ")}] are repeated."
          return false
        end

        return rule_verified
      end
    end
  end
end
