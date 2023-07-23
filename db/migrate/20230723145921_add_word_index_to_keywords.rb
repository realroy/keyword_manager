# frozen_string_literal: true

class AddWordIndexToKeywords < ActiveRecord::Migration[7.0]
  def change
    add_index :keywords, :word, unique: true
  end
end
