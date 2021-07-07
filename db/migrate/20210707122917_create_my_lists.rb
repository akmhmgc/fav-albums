class CreateMyLists < ActiveRecord::Migration[6.0]
  def change
    create_table :my_lists do |t|
      t.string :public_uid

      t.timestamps
    end
  end
end
