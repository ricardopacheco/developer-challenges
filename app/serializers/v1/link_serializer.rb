# frozen_string_literal: true

module V1
  class LinkSerializer
    include JSONAPI::Serializer

    attributes :id, :short, :url, :expires_at, :created_at, :visit_links_count
  end
end
