# frozen_string_literal: true

require "rails_helper"

RSpec.describe LinkContext::ViewLinkService, type: :service do
  let(:link) { create(:link) }
  let(:link_model_class) { Link }
  let(:visit_link_model_class) { VisitLink }

  describe ".call(attributes = {})" do
    subject(:service) { described_class.call(attributes) }

    context "when contract is invalid" do
      let(:attributes) { Dry::Core::Constants::EMPTY_HASH }

      it "expect to return an error and not persist in the database" do
        expect { service }.not_to change(link_model_class, :count)

        expect(service.failure[:short]).to include(I18n.t("contracts.errors.key?"))
      end
    end

    context "when occours invalidation data in visit link model" do
      let(:attributes) { { short: link.short } }

      before do
        allow_any_instance_of(visit_link_model_class).to receive(:save).and_return(false)
        allow_any_instance_of(visit_link_model_class)
          .to receive(:errors)
          .and_return(
            ActiveModel::Errors.new(visit_link_model_class.new).tap do |e|
              e.add(:metadata, I18n.t("errors.messages.blank"))
            end
          )
      end

      it "expect return failure and return model error messages" do
        expect(subject).to be_failure
        expect(subject.failure[:metadata]).to include(I18n.t("errors.messages.blank"))
      end
    end

    context "when operation is valid" do
      let(:attributes) { { short: link.short } }

      before { link.touch }

      it "expect to return success by creating visit link with counter cache in the database" do
        expect { service }
          .to change(VisitLink, :count)
          .from(0)
          .to(1)
          .and change { link.reload.visit_links_count }
          .from(0)
          .to(1)

        expect(service).to be_success
        expect(service.failure).to be_blank
      end
    end
  end
end
