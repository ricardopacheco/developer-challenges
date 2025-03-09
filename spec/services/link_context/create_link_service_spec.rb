# frozen_string_literal: true

require "rails_helper"

RSpec.describe LinkContext::CreateLinkService, type: :service do
  let(:link_model_class) { Link }

  describe ".call(attributes = {})" do
    subject(:service) { described_class.call(attributes) }

    context "when contract is invalid" do
      let(:attributes) { Dry::Core::Constants::EMPTY_HASH }

      it "expect to return an error and not persist in the database" do
        expect { service }.not_to change(link_model_class, :count)

        expect(service.failure[:url]).to include(I18n.t("contracts.errors.key?"))
      end
    end

    context "when occours invalidation data in link model" do
      let(:attributes) { attributes_for(:link).slice(:url) }

      before do
        allow_any_instance_of(link_model_class).to receive(:save).and_return(false)
        allow_any_instance_of(link_model_class)
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
      let(:attributes) { attributes_for(:link).slice(:url) }

      it "expect to return success by creating link in the database" do
        expect { service }.to change(link_model_class, :count).from(0).to(1)

        expect(service).to be_success
        expect(service.failure).to be_blank
      end
    end
  end
end
