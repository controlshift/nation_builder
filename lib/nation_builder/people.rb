# frozen_string_literal: true

module NationBuilder
  class People < Resource
    def show(id) = client.get(member_path(id)).body
    def create(params) = client.post(base_path, params).body
    def update(id, params) = client.put(member_path(id), params).body
    def search(params) = client.get("#{base_path}/search", params).body
    def push(params) = client.put("#{base_path}/push", params).body
    def add(params) = client.put("#{base_path}/add", params).body

    # @return [Hash, nil] the matching person, or nil when NationBuilder finds no match
    def match(params)
      client.get("#{base_path}/match", params).body
    rescue Error => e
      return nil if e.code == 'no_matches'

      raise
    end

    def taggings(person_id) = client.get(taggings_path(person_id)).body
    def add_tagging(person_id, tag) = client.put(taggings_path(person_id), { 'tagging' => { 'tag' => tag } }).body

    def delete_tagging(person_id, tag)
      client.delete("#{taggings_path(person_id)}/#{URI.encode_uri_component(tag.to_s)}")
      nil
    end

    private

    def base_path = 'people'
    def taggings_path(person_id) = "#{member_path(person_id)}/taggings"
  end
end
