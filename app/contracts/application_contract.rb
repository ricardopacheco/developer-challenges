# frozen_string_literal: true

# The class includes several macros for common validation tasks, such as validating url format.
# These macros utilize regular expressions and predefined length ranges
# to ensure the input data meets specific criteria.
# @abstract
class ApplicationContract < Dry::Validation::Contract
  I18N_MACRO_SCOPE = "contracts.errors.custom.macro"

  config.messages.backend = :i18n
  config.messages.default_locale = I18n.default_locale
  config.messages.top_namespace = "contracts"

  # Validates whether the provided value matches the url regex format.
  register_macro(:url_format) do
    next if URL_REGEX_CONSTANT.match?(value)

    key.failure(I18n.t(:url_format, scope: I18N_MACRO_SCOPE))
  end
end
