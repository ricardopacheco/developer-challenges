# frozen_string_literal: true

class AddVisitLinkCountToLinks < ActiveRecord::Migration[8.0]
  def change
    add_column :links, :visit_links_count, :integer, default: 0, null: false
  end
end
