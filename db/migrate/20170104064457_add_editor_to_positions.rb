class AddEditorToPositions < ActiveRecord::Migration
  def change
    change_table :positions do |t|
      t.boolean "editor", null: false
    end
  end
end
