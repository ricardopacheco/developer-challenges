# frozen_string_literal: true

module LinkContext
  class DeleteLinkServiceContract < ApplicationContract
    option :link_repository, default: proc { Link }

    params do
      required(:id).filled(:integer)

      before(:value_coercer) do |result|
        result.to_h.compact
      end
    end

    rule(:id) do |context:|
      context[:link] ||= link_repository.find_by(id: value)
      next if context[:link].present?

      key.failure(I18n.t("contracts.errors.custom.default.not_found"))
    end
  end
end
