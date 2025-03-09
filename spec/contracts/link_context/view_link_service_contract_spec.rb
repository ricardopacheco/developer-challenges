# frozen_string_literal: true

require "rails_helper"

RSpec.describe LinkContext::ViewLinkServiceContract, type: :contract do
  let(:link) { create(:link) }

  describe ".call" do
    subject(:contract) { described_class.new.call(attributes) }

    context "when attributes are blank" do
      let(:attributes) { Dry::Core::Constants::EMPTY_HASH }

      it "expect failure with error messages" do
        expect(contract).to be_failure
        expect(contract.errors[:short]).to include(I18n.t("contracts.errors.key?"))
      end
    end

    context "when the link is not found in the database" do
      let(:attributes) { {short: "shot-rxample"} }

      it "expect failure with error messages" do
        expect(contract).to be_failure
        expect(contract.errors[:short]).to include(I18n.t("record_not_found"))
      end
    end

    context "when the link is found in the database" do
      let(:attributes) { {short: link.short} }

      context "when link is expired" do
        let(:link) { create(:link, :with_expired_date_skip_validation) }

        it "expect failure with error messages" do
          expect(contract).to be_failure
          expect(contract.errors[:short]).to include(I18n.t("record_not_found"))
        end
      end

      context "when link is not expired" do
        let(:link) { create(:link, :with_expired_valid_date) }

        it "expect to return success" do
          expect(contract).to be_success
          expect(contract.errors).to be_blank
        end
      end
    end
  end
end
