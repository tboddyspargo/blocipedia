class CreateWikisAndUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :collaborators do |t|
      t.integer :wiki_id
      t.integer :user_id
      t.timestamps
    end
    
    add_index :collaborators, :id, unique: true
    add_index :collaborators, :wiki_id
    add_index :collaborators, :user_id
  end
end
