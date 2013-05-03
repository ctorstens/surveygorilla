class CreateUsers < ActiveRecord::Migration
   def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_hash
      t.string :token
    end
  end
end