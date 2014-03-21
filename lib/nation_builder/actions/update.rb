module NationBuilder
  module Actions
    module Update

      def update id, params
        body = JSON.generate(params)
        JSON.parse(client.put("#{base_path}#{id}", body: body).response.env[:body])
      end

    end
  end
end
