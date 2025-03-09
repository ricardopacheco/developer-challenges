# frozen_string_literal: true

module LinkContext
  class UpdateLinkService < ApplicationService
    def call(attributes = {})
      link, attributes = yield validate_contract(attributes)

      ActiveRecord::Base.transaction do
        link = yield update_link_on_database(link, attributes)
      end

      Success(link)
    end

    private

    def validate_contract(attributes)
      contract = LinkContext::UpdateLinkServiceContract.new.call(attributes)

      return Failure(contract.errors.to_hash) if contract.failure?

      Success([contract.context[:link], contract.to_h])
    end

    def update_link_on_database(link, attributes)
      return Success(link) if link.update(attributes)

      Failure(link.errors.to_hash)
    end
  end
end
