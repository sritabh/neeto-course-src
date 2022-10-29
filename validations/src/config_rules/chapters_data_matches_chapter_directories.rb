require_relative './base'

module Src
  module ConfigRules
    class ChaptersDataMatchesChapterDirectories < Src::ConfigRules::Base
      attr_reader :chapters_data, :chapter_directories, :course_base_directory_name

      def initialize(chapters_data, chapter_directories, course_base_directory_name)
        @chapters_data = chapters_data
        @chapter_directories = chapter_directories
        @course_base_directory_name = course_base_directory_name
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true

        sorted_chapter_directories = chapter_directories.sort
        chapter_slugs_as_in_metadata = chapters_data.map { |course| course["slug"] }
        chapter_slugs_as_in_chapter_directories = sorted_chapter_directories.map { |chapter_directory| File.basename(chapter_directory).split("-", 2)[1] }

        if chapter_slugs_as_in_metadata != chapter_slugs_as_in_chapter_directories
          missing_chapters_in_directories = chapter_slugs_as_in_metadata - chapter_slugs_as_in_chapter_directories
          missing_chapters_in_metadata = chapter_slugs_as_in_chapter_directories - chapter_slugs_as_in_metadata

          if missing_chapters_in_directories.length > 0
            @error_message = "Chapter directories are missing for chapters [#{missing_chapters_in_directories.join(", ")}] specified in chapters.yml in the course #{course_base_directory_name}."
          elsif missing_chapters_in_metadata.length > 0
            @error_message = "Chapter data in chapters.yml is missing for chapters [#{missing_chapters_in_metadata.join(", ")}] specified in chapters directory in the course #{course_base_directory_name}."
          else
            chapter_slugs_mismatched_in_order = chapter_slugs_as_in_metadata.select{ |slug, index| chapter_slugs_as_in_chapter_directories.index(slug) != index }
            @error_message = "Chapter directories are not in the same order as chapters in chapters.yml for the follwing chapters [#{chapter_slugs_mismatched_in_order.join(", ")}] in the course #{course_base_directory_name}."
          end
          return false
        end

        return rule_verified
      end
    end
  end
end
