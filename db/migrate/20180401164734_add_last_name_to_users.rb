class AddLastNameToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :last_name, :string
    add_index :users, :last_name
  end
end
