# frozen_string_literal: true

module ControllersHelper
  def json_response
    return if response.body.blank?

    JSON.parse(response.body, symbolize_keys: true).with_indifferent_access
  end
end

RSpec.configure do |c|
  c.include ControllersHelper, type: :controller
end
