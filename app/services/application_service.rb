# frozen_string_literal: true

# Abstract base class for services.
# @abstract
class ApplicationService
  include Dry::Monads[:do, :maybe, :result, :try]

  def self.call(*args, **kwargs, &block)
    service = new.call(*args, **kwargs)

    return service unless block

    Dry::Matcher::ResultMatcher.call(service, &block)
  end
end
