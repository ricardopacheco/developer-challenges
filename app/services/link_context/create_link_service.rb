# frozen_string_literal: true

module LinkContext
  class CreateLinkService < ApplicationService
    def call(attributes = {})
      attributes = yield validate_contract(attributes)

      ActiveRecord::Base.transaction do
        @link = yield create_link_on_database(attributes)
      end

      Success(@link)
    end

    private

    def validate_contract(attributes)
      contract = LinkContext::CreateLinkServiceContract.new.call(attributes)

      return Failure(contract.errors.to_hash) if contract.failure?

      Success(contract.to_h)
    end

    def create_link_on_database(attributes)
      link = Link.new(attributes)

      return Failure(link.errors.to_hash) unless link.save

      Success(link)
    end
  end
end
