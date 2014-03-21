module NationBuilder
  module Actions
    module Create
      def create params
        body = JSON.generate(params)
        JSON.parse(client.post(base_path, body: body).response.env[:body])
      end
    end
  end
end
