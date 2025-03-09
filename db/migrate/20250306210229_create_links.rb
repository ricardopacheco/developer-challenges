# frozen_string_literal: true

class CreateLinks < ActiveRecord::Migration[8.0]
  def change
    create_table :links do |t|
      t.string :url, null: false
      t.string :short, null: false, index: { unique: true }
      t.datetime :expires_at

      t.timestamps
    end

    add_index :links, %i[short expires_at], where: "expires_at IS NOT NULL"

    add_check_constraint :links, "LENGTH(short) BETWEEN 5 AND 10", name: "short_length_check"
    add_check_constraint :links, "LENGTH(url) BETWEEN 3 AND 2000", name: "url_length_check"
  end
end
