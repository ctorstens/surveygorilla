class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.text :choice
      t.references :question
    end
  end
end
