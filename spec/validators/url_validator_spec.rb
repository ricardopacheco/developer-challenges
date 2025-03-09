# frozen_string_literal: true

require 'rails_helper'

class DummyLink
  include ActiveModel::Model
  include ActiveModel::Validations

  attr_accessor :url

  validates :url, presence: true
  validates :url, url: true, if: -> { url.present? }
end

describe UrlValidator, type: :validator do
  subject(:dummy_link_class) { DummyLink }

  describe "with valid URL's" do
    UrlFakeData.valid_urls.each do |url|
      let(:link) { dummy_link_class.new(url: url) }

      it "expects URL to be valid" do
        expect(link).to be_valid
        expect(link.errors[:url]).to be_blank
      end
    end
  end

  describe "with invalid URL's" do
    UrlFakeData.invalid_urls.each do |url|
      let(:link) { dummy_link_class.new(url: url) }

      it "expects URL to be invalid" do
        expect(link).to be_invalid
        expect(link.errors[:url]).to include(I18n.t('errors.messages.invalid'))
      end
    end
  end
end
