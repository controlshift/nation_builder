# frozen_string_literal: true

module NationBuilder
  class Client
    attr_reader :hostname, :connection

    # @param hostname [String] the nation's hostname, without protocol, e.g. "mynation.nationbuilder.com"
    # @param token [String] OAuth 2.0 access token
    # @param instrumentation [#call, nil] called before every request with { path:, request_type: };
    #   numeric IDs in the path are replaced with "_"
    # @param logger [Logger, nil] when given, rate limit headers from each response are logged at info level
    # @param adapter [Symbol] Faraday adapter
    def initialize(hostname:, token:, instrumentation: nil, logger: nil, adapter: Faraday.default_adapter,
                   open_timeout: 10, timeout: 30)
      @hostname = hostname
      @instrumentation = instrumentation
      @logger = logger
      @connection = build_connection(token, adapter, { open_timeout:, timeout: })
    end

    def people = People.new(self)
    def tags = Tags.new(self)

    def get(path, params = nil) = request(:get, path, params:)
    def post(path, body) = request(:post, path, body:)
    def put(path, body) = request(:put, path, body:)
    def delete(path) = request(:delete, path)

    private

    def build_connection(token, adapter, request_options)
      Faraday.new(url: "https://#{hostname}/api/v1/", headers: { 'Accept' => 'application/json' },
                  request: request_options) do |f|
        f.request :authorization, 'Bearer', token
        f.request :json
        f.response :json, content_type: /\bjson$/
        f.adapter adapter
      end
    end

    def request(method, path, params: nil, body: nil)
      @instrumentation&.call(path: path.gsub(%r{(?<=/)\d+(?=/|\z)}, '_'), request_type: method)

      response = connection.run_request(method, path, body, nil) do |req|
        req.params.update(params) if params
      end
      log_rate_limit(response)
      raise Error.from_response(response) unless response.success?

      response
    end

    def log_rate_limit(response)
      return unless @logger

      headers = response.headers
      @logger.info(
        "NationBuilder rate limit headers for #{hostname}: " \
        "limit=#{headers['x-ratelimit-limit']} remaining=#{headers['x-ratelimit-remaining']} " \
        "reset=#{headers['x-ratelimit-reset'] && Time.at(headers['x-ratelimit-reset'].to_i)}"
      )
    end
  end
end
