require_relative './base'

module Src
  module ConfigRules
    class PageImageTagsValid < Src::ConfigRules::Base
      attr_reader :page_file, :course_base_directory_name, :chapter_base_directory_name, :images_path, :course_assets_config

      def initialize(page_file, course_base_directory_name, chapter_base_directory_name, images_path, course_assets_config)
        @page_file = page_file
        @course_base_directory_name = course_base_directory_name
        @chapter_base_directory_name = chapter_base_directory_name
        @images_path = images_path
        @course_assets_config = course_assets_config
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true

        page_file_basename = File.basename(page_file)
        page_content = File.read(page_file)

        image_tags = page_content.scan(/(<image.*>(.*)<\/image>)/)
        image_tags.each do |image_tag, image_name|
          expected_image_file_path = File.join(images_path, image_name)
          if !File.exists?(expected_image_file_path)
            @error_message = "image #{image_name} specified on image tag: #{image_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name} not found in assets/images"
            return false
          end

          unless course_assets_config["images"].include?(image_name)
            @error_message = "image #{image_name} specified on image tag: #{image_tag} on page: #{page_file_basename} in chapter #{chapter_base_directory_name} in course #{course_base_directory_name} should belong to the values in #{course_base_directory_name}/assets.yml"
            return false
          end
        end

        return rule_verified
      end
    end
  end
end
