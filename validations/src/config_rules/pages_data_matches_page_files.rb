require_relative './base'

module Src
  module ConfigRules
    class PagesDataMatchesPageFiles < Src::ConfigRules::Base
      attr_reader :pages_data, :page_files, :course_base_directory_name, :chapter_base_directory_name

      def initialize(pages_data, page_files, course_base_directory_name, chapter_base_directory_name)
        @pages_data = pages_data
        @page_files = page_files
        @course_base_directory_name = course_base_directory_name
        @chapter_base_directory_name = chapter_base_directory_name
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true

        sorted_page_files = page_files.sort
        page_slugs_as_in_metadata = pages_data.map { |page| page["slug"] }
        page_slugs_as_in_page_files = sorted_page_files.map { |page_directory| File.basename(page_directory, File.extname(page_directory)).split("-", 2)[1] }

        if page_slugs_as_in_metadata != page_slugs_as_in_page_files
          missing_pages_in_files = page_slugs_as_in_metadata - page_slugs_as_in_page_files
          missing_pages_in_metadata = page_slugs_as_in_page_files - page_slugs_as_in_metadata

          if missing_pages_in_files.length > 0
            @error_message = "Page files are missing for pages [#{missing_pages_in_files.join(", ")}] specified in pages.yml in chapter #{chapter_base_directory_name} in the course #{course_base_directory_name}."
          elsif missing_pages_in_metadata.length > 0
            @error_message = "Page data in pages.yml is missing for pages [#{missing_pages_in_metadata.join(", ")}] specified in pages directory in chapter #{chapter_base_directory_name} in the course #{course_base_directory_name}."
          else
            page_slugs_mismatched_in_order = page_slugs_as_in_metadata.select{ |slug, index| page_slugs_as_in_page_files.index(slug) != index }
            @error_message = "Page files are not in the same order as pages in pages.yml for the follwing pages [#{page_slugs_mismatched_in_order.join(", ")}] in chapter #{chapter_base_directory_name} in the course #{course_base_directory_name}."
          end
          return false
        end

        return rule_verified
      end
    end
  end
end
