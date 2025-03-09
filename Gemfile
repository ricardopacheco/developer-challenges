source "https://rubygems.org"

gem "rails", "8.0.1"
gem "pg", "1.5.9"
gem "puma", "6.6.0"
gem "bootsnap", require: false

gem "defaults", "2.0.0"
gem "nanoid", "2.0.0"
gem "jsonapi-serializer", "2.2.0"

# Tools for write clear, flexible, and more maintainable Ruby code.
gem "dry-matcher", "1.0.0"
gem "dry-monads", "1.7.1"
gem "dry-validation", "1.11.1"

group :development, :test do
  gem "brakeman", require: false
  gem "dotenv-rails", "3.1.7"
  gem "faker", "3.5.1"
  gem "pry-rails", "0.3.11"
  gem "standard", "1.45.0", require: false
end

group :development do
  gem "rspec-rails", "7.1.1"
end

group :test do
  gem "database_cleaner-active_record", "2.2.0"
  gem "factory_bot_rails", "6.4.4"
  gem "shoulda-matchers", "6.4.0"
  gem "simplecov", "0.22.0", require: false
end
