require_relative './base'

module Src
  module ConfigRules
    class PageEditorTagsValid < Src::ConfigRules::Base
      attr_reader :page_file, :course_base_directory_name, :chapter_base_directory_name, :databases_path

      def initialize(page_file, course_base_directory_name, chapter_base_directory_name, databases_path)
        @page_file = page_file
        @course_base_directory_name = course_base_directory_name
        @chapter_base_directory_name = chapter_base_directory_name
        @databases_path = databases_path
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true

        page_file_basename = File.basename(page_file)
        page_content = File.read(page_file)

        editor_tags = page_content.scan(/(<Editor.*>)/)
        editor_tags.flatten.each do |editor_tag|
          lang = editor_tag[1..-2].split(" ").select{|s| s.start_with?("lang=")}[0]&.split("=")&.dig(1)&.gsub("\"", "")
          if lang.nil? || lang.empty?
            @error_message = "lang attribute not found on editor tag: #{editor_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name}"
            return false
          end
          if lang == "sql"
            dbName = editor_tag[1..-2].split(" ").select{|s| s.start_with?("dbName=")}[0]&.split("=")&.dig(1)&.gsub("\"", "")
            if dbName.nil? || dbName.empty?
              @error_message = "dbName attribute not found on editor tag: #{editor_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name}"
              return false
            end
            expected_db_file_path = File.join(databases_path, dbName)
            if !File.exists?(expected_db_file_path)
              @error_message = "dbName #{dbName} specified on editor tag: #{editor_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name} not found in assets/databases"
              return false
            end
          end
        rescue StandardError => e
          @error_message = "Error while parsing editor tag: #{editor_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name} : error: #{e.message}"
          return false
        end

        return rule_verified
      end
    end
  end
end
