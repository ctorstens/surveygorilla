class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.references :survey
      t.string :title
      t.text :help_text
      t.string :type
      t.integer :position
      t.boolean :required
      t.timestamps
    end
  end
end
