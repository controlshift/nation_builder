# frozen_string_literal: true

module NationBuilder
  class Tags < Resource
    def people(tag) = client.get("#{member_path(tag)}/people").body

    private

    def base_path = 'tags'
  end
end
