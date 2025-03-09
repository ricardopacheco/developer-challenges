# frozen_string_literal: true

require "rails_helper"

RSpec.describe LinkContext::DeleteLinkService, type: :service do
  let(:link) { create(:link) }
  let(:link_model_class) { Link }

  describe ".call(attributes = {})" do
    subject(:service) { described_class.call(attributes) }

    context "when contract is invalid" do
      let(:attributes) { Dry::Core::Constants::EMPTY_HASH }

      it "expect to return an error and not persist in the database" do
        expect { service }.not_to change(link_model_class, :count)

        expect(service.failure[:id]).to include(I18n.t("contracts.errors.key?"))
      end
    end

    context "when occours invalidation data in link model" do
      let(:attributes) { {id: link.id} }

      before do
        allow(link_model_class).to receive(:find_by).and_return(link)
        allow(link).to receive(:destroy).and_return(false)
        allow(link)
          .to receive(:errors)
          .and_return(
            ActiveModel::Errors.new(link_model_class.new).tap do |e|
              e.add(:url, I18n.t("errors.messages.blank"))
            end
          )
      end

      it "expect return failure and return model error messages" do
        expect(subject).to be_failure
        expect(subject.failure[:url]).to include(I18n.t("errors.messages.blank"))
      end
    end

    context "when operation is valid" do
      let(:attributes) { {id: link.id} }

      before { link.touch }

      it "expect to return success by creating link in the database" do
        expect { service }.to change(link_model_class, :count).from(1).to(0)

        expect(service).to be_success
        expect(service.failure).to be_blank
      end
    end
  end
end
