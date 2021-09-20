class AddFirstNameToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :first_name, :string
    add_index :users, :first_name
  end
end
