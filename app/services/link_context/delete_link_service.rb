# frozen_string_literal: true

module LinkContext
  class DeleteLinkService < ApplicationService
    def call(attributes = {})
      link = yield validate_contract(attributes)

      ActiveRecord::Base.transaction do
        yield remove_link_on_database(link)
      end

      Success(true)
    end

    private

    def validate_contract(attributes)
      contract = LinkContext::DeleteLinkServiceContract.new.call(attributes)

      return Failure(contract.errors.to_hash) if contract.failure?

      Success(contract.context[:link])
    end

    def remove_link_on_database(link)
      return Success(true) if link.destroy

      Failure(link.errors.to_hash)
    end
  end
end
