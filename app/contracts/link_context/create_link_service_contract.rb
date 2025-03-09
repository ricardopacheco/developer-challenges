# frozen_string_literal: true

module LinkContext
  class CreateLinkServiceContract < ApplicationContract
    params do
      required(:url).filled(:string)
      optional(:expires_at).value(:time)

      before(:value_coercer) do |result|
        result.to_h.compact
      end
    end

    rule(:url).validate(:url_format)
  end
end
