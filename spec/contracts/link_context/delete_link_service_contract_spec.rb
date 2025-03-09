# frozen_string_literal: true

require "rails_helper"

RSpec.describe LinkContext::DeleteLinkServiceContract, type: :contract do
  let(:link) { create(:link) }

  describe ".call" do
    subject(:contract) { described_class.new.call(attributes) }

    context "when attributes are blank" do
      let(:attributes) { Dry::Core::Constants::EMPTY_HASH }

      it "expect failure with error messages" do
        expect(contract).to be_failure

        expect(contract.errors[:id]).to include(I18n.t("contracts.errors.key?"))
      end
    end

    context "when the link is not found in the database" do
      let(:attributes) { {id: 100_000} }

      it "expect failure with error messages" do
        expect(contract).to be_failure
        expect(contract.errors[:id]).to include(
          I18n.t("contracts.errors.custom.default.not_found")
        )
      end
    end

    context "when the link is found in the database" do
      let(:attributes) { {id: link.id} }

      it "expect to return success" do
        expect(contract).to be_success
        expect(contract.errors).to be_blank
      end
    end
  end
end
