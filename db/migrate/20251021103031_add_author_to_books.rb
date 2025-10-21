class AddAuthorToBooks < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_reference :books, :author, index: { algorithm: :concurrently }, foreign_key: false
  end
end