# frozen_string_literal: true

class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?

    unless value.match?(URL_REGEX_CONSTANT)
      record.errors.add(attribute, :invalid_url, message: :invalid)
    end
  end
end
