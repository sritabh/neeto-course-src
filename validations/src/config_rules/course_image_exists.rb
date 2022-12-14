require_relative './base'

module Src
  module ConfigRules
    class CourseImageExists < Src::ConfigRules::Base
      attr_reader :course_data, :course_index, :image_type, :images_path, :course_assets_config ,:course_directory

      def initialize(course_data, course_index, image_type, images_path, course_directory, course_assets_config)
        @course_data = course_data
        @course_index = course_index
        @image_type = image_type
        @images_path = images_path
        @course_assets_config = course_assets_config
        @course_directory = course_directory
        @error_message = ""
      end

      def rule_verified?
        rule_verified = true
        image_file_name = course_data[image_type]
        expected_file_path = File.join(images_path, image_file_name)
        if !File.exists?(expected_file_path)
          @error_message = "Course image #{image_file_name} does not exist in assets/images for course #{course_data["name"]} at index #{course_index}."
          return false
        end

        unless course_assets_config["images"].include?(image_file_name)
          @error_message = "Course image #{image_file_name} should belong to the values in #{course_directory}/assets.yml"
          return false
        end
        rule_verified
      end
    end
  end
end
