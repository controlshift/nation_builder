module NationBuilder
  class Tags < RemoteController
    include NationBuilder::Actions::List

    def controller_name
      'tags'
    end
  end
end