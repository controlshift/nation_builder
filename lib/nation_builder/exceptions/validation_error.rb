module NationBuilder
  module Exceptions
    class ValidationError < StandardError
      attr_accessor :message, :errors, :code

      def initialize(message, errors, code)
        self.message = message
        self.errors = errors
        self.code = code
        super()
      end

      def to_s
        "#{super()} \n message: #{message} \n code: #{code} \n errors: #{errors}"
      end
      
    end
  end
end
