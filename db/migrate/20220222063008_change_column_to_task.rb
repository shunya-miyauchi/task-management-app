class ChangeColumnToTask < ActiveRecord::Migration[5.2]
  def up
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :detail, :text, null: false
  end
end
