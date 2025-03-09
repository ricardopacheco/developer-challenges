# frozen_string_literal: true

require "rails_helper"

RSpec.describe LinkContext::CreateLinkServiceContract, type: :contract do
  describe ".call" do
    subject(:contract) { described_class.new.call(attributes) }

    context "when attributes are blank" do
      let(:attributes) { Dry::Core::Constants::EMPTY_HASH }

      it "expect failure with error messages" do
        expect(contract).to be_failure

        expect(contract.errors[:url]).to include(I18n.t("contracts.errors.key?"))
      end
    end

    context "when url is in wrong format" do
      let(:attributes) { {url: "wrongurl"} }

      it "expect failure with error messages" do
        expect(contract).to be_failure
        expect(contract.errors[:url]).to include(I18n.t("contracts.errors.custom.macro.url_format"))
      end
    end

    context "when expires_at is invalid" do
      let(:attributes) { {url: "example.com", expires_at: Date.current} }

      it "expect failure with error messages" do
        expect(contract).to be_failure
        expect(contract.errors[:expires_at]).to include(I18n.t("contracts.errors.time?"))
      end
    end

    context "when attributes are valid" do
      let(:attributes) { {url: "example.com", expires_at: 1.week.from_now} }

      it "expect success" do
        expect(contract).to be_success
        expect(contract.errors).to be_blank
      end
    end
  end
end
