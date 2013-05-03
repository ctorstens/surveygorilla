class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :user
      t.references :option
    end
  end
end
