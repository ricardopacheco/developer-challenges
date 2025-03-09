# frozen_string_literal: true

class Link < ApplicationRecord
  defaults short: proc {
    Nanoid.generate(size: rand(5..10), alphabet: LINK_SHORT_CHARACTERS)
  }

  has_many :visit_links, dependent: :destroy

  validates :url, presence: true, length: { minimum: 3, maximum: 2000 }
  validates :url, url: true, if: -> { url.present? }
  validates :short, presence: true, uniqueness: true, length: { in: 5..10 }
  validates_comparison_of :expires_at, greater_than: -> { Time.current }, if: -> { expires_at.present? }

  scope :active, -> { where("expires_at IS NULL OR expires_at >= ?", Time.current) }

  def enable?
    return true if expires_at.blank?

    expires_at >= Time.current
  end
end
