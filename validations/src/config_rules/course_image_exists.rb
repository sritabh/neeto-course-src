require_relative './base'

module Src
  module ConfigRules
    class CourseImageExists < Src::ConfigRules::Base
      attr_reader :course_data, :course_index, :image_type, :images_path

      def initialize(course_data, course_index, image_type, images_path)
        @course_data = course_data
        @course_index = course_index
        @image_type = image_type
        @images_path = images_path
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
        rule_verified
      end
    end
  end
end
