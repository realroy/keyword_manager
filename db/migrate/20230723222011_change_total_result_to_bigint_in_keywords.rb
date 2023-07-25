# frozen_string_literal: true

class ChangeTotalResultToBigintInKeywords < ActiveRecord::Migration[7.0]
  def change
    change_column :keywords, :total_result, :bigint
  end
end
