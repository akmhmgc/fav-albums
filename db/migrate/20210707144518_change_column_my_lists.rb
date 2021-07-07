class ChangeColumnMyLists < ActiveRecord::Migration[6.0]
  def change
    change_column :my_lists, :nickname, :string, null: false, limit: 10
  end
end
