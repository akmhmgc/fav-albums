class AddImageToMyLists < ActiveRecord::Migration[6.0]
  def change
    add_column :my_lists, :image, :string
  end
end
