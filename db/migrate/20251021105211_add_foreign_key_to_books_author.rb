class AddForeignKeyToBooksAuthor < ActiveRecord::Migration[8.0]
  def change
    safety_assured do
      add_foreign_key :books, :authors
    end
  end
end