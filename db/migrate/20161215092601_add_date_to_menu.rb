class AddDateToMenu < ActiveRecord::Migration[5.0]
  def change
    add_column :menus, :date, :date
  end
end
