# frozen_string_literal: true

class CreateKeywords < ActiveRecord::Migration[7.0]
  def change
    create_table :keywords do |t|
      t.string :word
      t.integer :total_adword
      t.integer :total_link
      t.integer :total_result
      t.decimal :total_search_time, precision: 15, scale: 2
      t.text :html

      t.timestamps
    end
  end
end
