class CreateAuthors < ActiveRecord::Migration[8.0]
  def change
    create_table :authors do |t|
      t.string :name, null: false
      t.text :bio
      t.boolean :active, default: true, null: false

      t.timestamps
    end

    add_index :authors, :name
    add_index :authors, :active
  end
end
