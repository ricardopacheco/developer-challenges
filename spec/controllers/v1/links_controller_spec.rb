# frozen_string_literal: true

require "rails_helper"

describe V1::LinksController, type: :controller do
  let(:link) { create(:link) }

  describe "Link routes", type: :routing do
    it { expect(get("/:short")).to route_to("v1/links#show", short: ":short") }
    it { expect(get("/v1/links")).to route_to("v1/links#index", format: :json) }
    it { expect(get("/v1/links/:id/info")).to route_to("v1/links#info", id: ":id", format: :json) }
    it { expect(post("/v1/links")).to route_to("v1/links#create", format: :json) }
    it { expect(put("/v1/links/:id")).to route_to("v1/links#update", id: ":id", format: :json) }
    it { expect(delete("/v1/links/:id")).to route_to("v1/links#destroy", id: ":id", format: :json) }
  end

  describe "GET #index" do
    context "when there are no enabled links" do
      before { get :index, format: :json }

      it "returns a success response without records" do
        expect(response).to have_http_status(:ok)
        expect(json_response[:data]).to be_blank
      end
    end

    context "when there are enabled links" do
      before { link.touch }

      it "returns a success response with link records" do
        get :index, format: :json

        expect(response).to have_http_status(:ok)
        expect(json_response.dig(:data, 0, :attributes, :url)).to eq(link.url)
      end
    end
  end

  describe "GET #info" do
    context "when the link does not exist" do
      before { get :info, params: { id: 100_000 }, format: :json }

      it "returns a not found response" do
        expect(response).to have_http_status(:not_found)
        expect(json_response[:error]).to eq(I18n.t("record_not_found"))
      end
    end

    context "when the link exists" do
      before { get :info, params: { id: link.id }, format: :json }

      it "returns a success response with link record" do
        expect(response).to have_http_status(:ok)
        expect(json_response.dig(:data, :attributes, :url)).to eq(link.url)
      end
    end
  end

  describe "GET #show" do
    context "when the link does not exist" do
      before { get :show, params: { short: "invalid" } }

      it "returns a not found response" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include(I18n.t("record_not_found"))
      end
    end

    context "when the link exists" do
      before { get :show, params: { short: link.short } }

      it "returns a permanent redirect response" do
        expect(response).to have_http_status(:permanent_redirect)
        expect(response.headers["Location"]).to eq(link.url)
      end
    end
  end

  describe "POST #create" do
    before { post :create, params: attributes, as: :json }

    context "with invalid params" do
      let(:attributes) { { url: nil } }

      it "renders a JSON response with errors" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:url]).to include(I18n.t("contracts.errors.key?"))
      end
    end

    context "with valid params" do
      let(:attributes) { { url: "url.com" } }

      it "expects create a new link" do
        expect(response).to have_http_status(:created)
        expect(json_response.dig(:data, :attributes, :id)).to be_present
        expect(json_response.dig(:data, :attributes, :url)).to eq(attributes[:url])
      end
    end
  end

  describe "PUT #update" do
    before { put :update, params: attributes, as: :json }

    context "with invalid params" do
      let(:attributes) { { id: link.id, url: nil } }

      it "renders a JSON response with errors" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:url]).to include(I18n.t("contracts.errors.key?"))
      end
    end

    context "with valid params" do
      let(:attributes) { { id: link.id, url: "updatedurl.com" } }

      it "expects update the link" do
        expect(response).to have_http_status(:ok)
        expect(json_response.dig(:data, :attributes, :id)).to eq(link.id)
        expect(json_response.dig(:data, :attributes, :url)).to eq(attributes[:url])
      end
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy, params: attributes, as: :json }

    context "with invalid params" do
      let(:attributes) { { id: 100_000 } }

      it "renders a JSON response with errors" do
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response[:id]).to include(I18n.t("contracts.errors.custom.default.not_found"))
      end
    end

    context "with valid params" do
      let(:attributes) { { id: link.id } }

      it "expects destroy the link" do
        expect(response).to have_http_status(:no_content)
        expect(json_response).to be_blank
      end
    end
  end
end
