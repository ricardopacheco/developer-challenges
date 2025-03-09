# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  describe "Default values" do
    subject(:link) { create(:link) }

    it "expects to have a valid record" do
      expect(link).to be_persisted
      expect(link.short).to be_present
      expect(link.short.size).to be_between(5, 10)
    end
  end

  describe "Associations" do
    it { is_expected.to have_many(:visit_links).dependent(:destroy) }
  end

  describe "General validations" do
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:short) }
    it { is_expected.to validate_length_of(:url).is_at_least(3).is_at_most(2000) }
    it { is_expected.to validate_length_of(:short).is_at_least(5).is_at_most(10) }
  end

  describe "Unique validations" do
    subject { build(:link, short: link.short) }

    let(:link) { create(:link, :with_expired_valid_date) }

    it { is_expected.to validate_uniqueness_of(:short) }
  end

  describe "Custom validations" do
    context "#expires_at" do
      context "when expires_at is greater than current time" do
        subject(:link) { build(:link, :with_expired_valid_date) }

        it "expects to be valid" do
          expect(link).to be_valid
          expect(link.errors[:expires_at]).to be_blank
        end
      end

      context "when expires_at is less than current time" do
        subject(:link) { build(:link, :with_expired_invalid_date) }

        it "expects to be invalid" do
          expect(link).to be_invalid
          expect(link.errors[:expires_at]).to include(I18n.t('errors.messages.greater_than', count: Time.current))
        end
      end
    end

    context "#url" do
      context "when url is valid" do
        subject(:link) { build(:link) }

        it "expects to be valid" do
          expect(link).to be_valid
          expect(link.errors[:url]).to be_blank
        end
      end

      context "when url is invalid" do
        subject(:link) { build(:link, :with_invalid_url) }

        it "expects to be invalid" do
          expect(link).to be_invalid
          expect(link.errors[:url]).to include(I18n.t('errors.messages.invalid'))
        end
      end
    end

    context "#enable?" do
      context "when expires_at is blank" do
        subject(:link) { build(:link, expires_at: nil) }

        it "expects be enable" do
          expect(link).to be_enable
        end
      end

      context "when expires_at is present and is greater than or equal to current time" do
        subject(:link) { build(:link, :with_expired_valid_date) }

        it "expects be enable" do
          expect(link).to be_enable
        end
      end

      context "when expires_at is present and is less than current time" do
        subject(:link) { build(:link, :with_expired_invalid_date) }

        it "expects return false" do
          expect(link).not_to be_enable
        end
      end
    end
  end
end
