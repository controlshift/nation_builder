module NationBuilder
  module Actions
    module List
      def list
        JSON.parse(client.get(base_path).response.env[:body])
      end
    end
  end
end
