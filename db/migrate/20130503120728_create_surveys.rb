class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.references :user
      t.string :title
      t.text :description
      t.string :token
      t.boolean :live, :default => false
      t.datetime :expiry_date
      t.timestamps
    end
  end
end
