module NationBuilder
  class RateLimitedError < StandardError
    def initialize(oauth2_response)
      message = "NationBuilder rate limit error. Current values:\n"
      message << "Limit: #{oauth2_response.headers["x-ratelimit-limit"]}\n"
      message << "Remaining: #{oauth2_response.headers["x-ratelimit-remaining"]}\n"
      message << "Reset: #{Time.at(oauth2_response.headers["x-ratelimit-reset"].try(:to_i) || 0)}"
      super(message)
    end
  end

  class Client
    attr_accessor :client, :token, :client_secret, :client_id, :username, :password, :hostname, :instrumentation

    def initialize(args = {})
      args.each do |key, value|
        self.send("#{key}=".intern, value)
      end
      if username.present? && password.present?
        self.client = setup_client_from_password
      elsif token.present?
        self.client = setup_client_from_token
      end
    end

    def people
      NationBuilder::People.new(self)
    end

    def tags
      NationBuilder::Tags.new(self)
    end

    def get(path, opts={})
      instrumented_request(:get, path, opts)
    end

    def post(path, opts={})
      instrumented_request(:post, path, opts)
    end

    def put(path, opts={})
      instrumented_request(:put, path, opts)
    end

    def delete(path, opts={})
      instrumented_request(:delete, path, opts)
    end

    private

    def instrumented_request(request_type, path, opts)
      if self.instrumentation
        # Normalize path to remove IDs from it
        normalized_path = path.gsub(/\/\d+\//, '/_/')
        stats = { path: normalized_path, request_type: request_type }
        self.instrumentation.call(stats)
      end

      begin
        self.client.send(request_type, "#{base_uri}#{path}", opts.merge(headers: headers))
      rescue OAuth2::Error => e
        if e.code.try(:downcase) == 'rate_limited'
          raise RateLimitedError.new(response)
        end

        raise
      end
    end

    def setup_client_from_password
      setup_client.password.get_token(username, password)
    end

    def setup_client_from_token
      OAuth2::AccessToken.new(setup_client, token)
    end

    def setup_client
      OAuth2::Client.new(client_id, client_secret, site: "https://#{hostname}", authorize_url: "https://#{hostname}/oauth/authorize", token_url: "https://#{hostname}/oauth/token" )
    end


    def headers
      {
        'Content-Type' => 'application/json',
        'Accept' => 'application/json'
      }
    end

    def base_uri
      "https://#{hostname}/"
    end
  end
end
