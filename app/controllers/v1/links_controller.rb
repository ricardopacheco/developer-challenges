# frozen_string_literal: true

module V1
  class LinksController < ApplicationController
    def index
      links = V1::LinkSerializer.new(Link.active)

      render json: links, status: :ok
    end

    def info
      link = Link.active.find_by(id: params[:id])

      if link.present?
        render json: V1::LinkSerializer.new(link), status: :ok
      else
        render json: {error: I18n.t("record_not_found")}, status: :not_found
      end
    end

    def show
      ::LinkContext::ViewLinkService.call(show_link_params) do |result|
        result.success { |link| redirect_to link.url, allow_other_host: true, status: :permanent_redirect }
        result.failure { |_| render json: I18n.t("record_not_found"), status: :unprocessable_entity }
      end
    end

    def create
      ::LinkContext::CreateLinkService.call(create_link_params) do |result|
        result.success { |link| render json: V1::LinkSerializer.new(link), status: :created }
        result.failure { |failure| render json: failure, status: :unprocessable_entity }
      end
    end

    def update
      ::LinkContext::UpdateLinkService.call(update_link_params) do |result|
        result.success { |link| render json: V1::LinkSerializer.new(link), status: :ok }
        result.failure { |failure| render json: failure, status: :unprocessable_entity }
      end
    end

    def destroy
      ::LinkContext::DeleteLinkService.call(destroy_link_params) do |result|
        result.success { |success| head :no_content }
        result.failure { |failure| render json: failure, status: :unprocessable_entity }
      end
    end

    private

    def show_link_params
      params.permit(:short)
        .with_defaults(metadata: {ip: request.remote_ip, user_agent: request.user_agent, referer: request.referer})
        .to_h.with_indifferent_access
    end

    def create_link_params
      params.permit(:url, :expires_at).to_h.with_indifferent_access
    end

    def update_link_params
      params.permit(:id, :url, :expires_at).to_h.with_indifferent_access
    end

    def destroy_link_params
      params.permit(:id).to_h.with_indifferent_access
    end
  end
end
