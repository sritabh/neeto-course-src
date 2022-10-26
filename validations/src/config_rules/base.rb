module Src
  module ConfigRules
    class Base
      attr_reader :error_message

      def process
        if rule_verified?
          true
        else
          raise error_message
        end
      end
    end
  end
end
