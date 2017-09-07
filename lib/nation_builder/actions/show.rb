module NationBuilder
  module Actions
    module Show
      def show(person_id)
        JSON.parse(client.get("#{base_path}/#{CGI.escape(person_id)}").response.env[:body])
      end
    end
  end
end
