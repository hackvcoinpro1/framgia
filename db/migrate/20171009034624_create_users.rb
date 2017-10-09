class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.integer :gender
      t.date :date_start
      t.string :university
      t.string :organization
      t.string :program
      t.string :avatar
      t.string :reset_digest
      t.datetime :reset_send_at
      t.boolean :suppervisor

      t.timestamps
    end
  end
end
