require_relative './base'

module Src
  module ConfigRules
    class PageCodeblockTagsValid < Src::ConfigRules::Base
      attr_reader :page_file, :course_base_directory_name, :chapter_base_directory_name, :databases_path, :course_assets_config

      CODEBLOCK_TYPES = ["lesson", "exercise"]
      CODEBLOCK_TEST_MODES= ["fixedInput", "multipleInput"]

      def initialize(page_file, course_base_directory_name, chapter_base_directory_name, databases_path, course_assets_config)
        @page_file = page_file
        @course_base_directory_name = course_base_directory_name
        @chapter_base_directory_name = chapter_base_directory_name
        @databases_path = databases_path
        @course_assets_config = course_assets_config
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true

        page_file_basename = File.basename(page_file)
        page_content = File.read(page_file)

        codeblock_tags = page_content.scan(/(<codeblock.*>)/)
        codeblock_tags.flatten.each do |codeblock_tag|
          language = codeblock_tag[1..-2].split(" ").select{|s| s.start_with?("language=")}[0]&.split("=")&.dig(1)&.gsub("\"", "")
          if language.nil? || language.empty?
            @error_message = "language attribute not found on codeblock tag: #{codeblock_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name}"
            return false
          end
          if language == "sql"
            dbName = codeblock_tag[1..-2].split(" ").select{|s| s.start_with?("dbName=")}[0]&.split("=")&.dig(1)&.gsub("\"", "")
            if dbName.nil? || dbName.empty?
              @error_message = "dbName attribute not found on codeblock tag: #{codeblock_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name}"
              return false
            end
            expected_db_file_path = File.join(databases_path, dbName)
            if !File.exists?(expected_db_file_path)
              @error_message = "dbName #{dbName} specified on codeblock tag: #{codeblock_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name} not found in assets/databases"
              return false
            end

            unless course_assets_config["databases"].include?(dbName)
              @error_message = "dbName #{dbName} specified on codeblock tag: #{codeblock_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name} should belong to the values in #{course_base_directory_name}/assets.yml"
              return false
            end
          end

          type = codeblock_tag[1..-2].split(" ").select{|s| s.start_with?("type=")}[0]&.split("=")&.dig(1)&.gsub("\"", "")
          if type.nil? || type.empty?
            @error_message = "type attribute not found on codeblock tag: #{codeblock_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name}"
            return false
          end

          unless CODEBLOCK_TYPES.include?(type)
            @error_message = "type attribute on codeblock tag: #{codeblock_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name} should be either lesson or exercise"
            return false
          end

          if type == "exercise"
            test_mode = codeblock_tag[1..-2].split(" ").select{|s| s.start_with?("testMode=")}[0]&.split("=")&.dig(1)&.gsub("\"", "")
            if test_mode.nil? || test_mode.empty?
              @error_message = "testMode attribute not found on codeblock tag: #{codeblock_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name}"
              return false
            end

            unless CODEBLOCK_TEST_MODES.include?(test_mode)
              @error_message = "testMode attribute on codeblock tag: #{codeblock_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name} should be either 'fixedInput' or 'multipleInput'"
              return false
            end
          end

          images_prop = codeblock_tag[1..-2].split(" ").select{|s| s.start_with?("images=")}[0]&.split("=")&.dig(1)&.gsub("\"", "")

          if images_prop
            image_list = images_prop.split(",").map { |str| str.strip }
            if (course_assets_config["images"] - image_list).empty?
              @error_message = "images attribute on codeblock tag: #{codeblock_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name} should belong to the values in #{course_base_directory_name}/assets.yml"
              return false
            end
          end

          
        rescue StandardError => e
          @error_message = "Error while parsing codeblock tag: #{codeblock_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name} : error: #{e.message}"
          return false
        end

        return rule_verified
      end
    end
  end
end
