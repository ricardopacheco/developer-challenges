# frozen_string_literal: true

FactoryBot.define do
  factory :link, class: "Link" do
    url { "https://example.com/#{SecureRandom.hex(5)}" }

    trait :with_invalid_url do
      url { "invalid-url" }
    end

    trait :with_expired_valid_date do
      expires_at { 1.week.from_now }
    end

    trait :with_expired_invalid_date do
      expires_at { 1.week.ago }
    end

    trait :with_expired_date_skip_validation do
      with_expired_invalid_date

      to_create { |instance| instance.save(validate: false) }
    end
  end
end
