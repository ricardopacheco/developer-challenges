# frozen_string_literal: true

module LinkContext
  class ViewLinkService < ApplicationService
    def call(attributes = {})
      link, metadata = yield validate_contract(attributes)

      ActiveRecord::Base.transaction do
        yield increase_visit_on_links(link, metadata)
      end

      Success(link)
    end

    private

    def validate_contract(attributes)
      contract = LinkContext::ViewLinkServiceContract.new.call(attributes)

      return Failure(contract.errors.to_hash) if contract.failure?

      Success([contract.context[:link], contract.to_h.slice(:metadata)])
    end

    def increase_visit_on_links(link, metadata)
      visit_link = VisitLink.new(link: link, metadata: metadata)

      return Success(true) if visit_link.save

      Failure(visit_link.errors.to_hash)
    end
  end
end
