# frozen_string_literal: true

module LinkContext
  class ViewLinkServiceContract < ApplicationContract
    option :link_repository, default: proc { Link }

    params do
      required(:short).filled(:string)
      optional(:metadata).value(:hash)

      before(:value_coercer) do |result|
        result.to_h.compact
      end
    end

    rule(:short) do |context:|
      context[:link] ||= link_repository.active.find_by(short: value)
      next if context[:link].present?

      key.failure(I18n.t("record_not_found"))
    end
  end
end
