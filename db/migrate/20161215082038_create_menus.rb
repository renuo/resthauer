class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.string :title
      t.decimal :price, precision: 8, scale: 2
      t.text :description

      t.timestamps
    end
  end
end
