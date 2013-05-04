class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.references :question
      t.references :completion
      t.references :option
      t.text :answer
      t.timestamps
    end
  end
end
