# frozen_string_literal: true

class CreateVisitLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :visit_links do |t|
      t.references :link, null: false, foreign_key: true
      t.jsonb :metadata, default: {}

      t.datetime :created_at
    end
  end
end
