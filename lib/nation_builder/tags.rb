module NationBuilder
  class Tags < RemoteController
    include NationBuilder::Actions::List

    def controller_name
      'tags'
    end

    def people(tag)
      JSON.parse(client.get("#{base_path}/#{CGI.escape(tag.to_s)}").response.env[:body])
    end
  end
end