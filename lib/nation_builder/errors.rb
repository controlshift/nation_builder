# frozen_string_literal: true

module NationBuilder
  # Raised for any non-2xx response. #code is NationBuilder's error code from the body, e.g. "not_found".
  class Error < StandardError
    attr_reader :response

    def self.from_response(response)
      body = response.body.is_a?(Hash) ? response.body : {}
      klass = if response.status == 429 || body['code'] == 'rate_limited' then RateLimitedError
              elsif body['code'] == 'validation_failed' then ValidationError
              elsif response.status == 404 then NotFoundError
              else Error
              end
      klass.new(response)
    end

    def initialize(response)
      @response = response
      super(build_message)
    end

    def status = response.status
    def body = response.body
    def code = body.is_a?(Hash) ? body['code'] : nil

    private

    def build_message
      "NationBuilder responded #{status}: #{body}"
    end
  end

  class NotFoundError < Error; end

  class ValidationError < Error
    def errors = body['validation_errors']
  end

  class RateLimitedError < Error
    def limit = response.headers['x-ratelimit-limit']
    def remaining = response.headers['x-ratelimit-remaining']

    def reset_at
      reset = response.headers['x-ratelimit-reset']
      reset && Time.at(reset.to_i)
    end

    private

    def build_message
      "NationBuilder rate limit error. Limit: #{limit}, remaining: #{remaining}, reset: #{reset_at}. Body: #{body}"
    end
  end
end
