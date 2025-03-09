# frozen_string_literal: true

require "rails_helper"

RSpec.describe LinkContext::UpdateLinkService, type: :service do
  let(:link_model_class) { Link }
  let(:link) { create(:link) }

  describe ".call(attributes = {})" do
    subject(:service) { described_class.call(attributes) }

    context "when contract is invalid" do
      let(:attributes) { Dry::Core::Constants::EMPTY_HASH }

      it "expect to return an error and not update record in the database" do
        expect { service }.not_to change(link, :url)

        expect(service.failure[:url]).to include(I18n.t("contracts.errors.key?"))
      end
    end

    context "when occours invalidation data in link model" do
      let(:attributes) { { id: link.id, url: 'updatedurl.com' } }

      before do
        allow(link_model_class).to receive(:find_by).and_return(link)
        allow(link).to receive(:update).and_return(false)
        allow(link)
          .to receive(:errors)
          .and_return(
            ActiveModel::Errors.new(link_model_class.new).tap do |e|
              e.add(:short, I18n.t("errors.messages.blank"))
            end
          )
      end

      it "expect return failure and return model error messages" do
        expect(subject).to be_failure
        expect(subject.failure[:short]).to include(I18n.t("errors.messages.blank"))
      end
    end

    context "when operation is valid" do
      let(:old_url) { link.url }
      let(:new_url) { 'updatedurl.com' }
      let(:attributes) { { id: link.id, url: new_url } }

      it "expect to return success by creating link in the database" do
        expect { service }.to change { link.reload.url }.from(old_url).to(new_url)

        expect(service).to be_success
        expect(service.failure).to be_blank
      end
    end
  end
end
