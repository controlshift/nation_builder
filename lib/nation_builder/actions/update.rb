module NationBuilder
  module Actions
    module Update

      def update id, params
        body = JSON.generate(params)
        JSON.parse(client.put("#{base_path}/#{CGI.escape(id.to_s)}", body: body).response.env[:body])
      end

    end
  end
end
