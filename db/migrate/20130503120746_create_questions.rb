class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :help_text
      t.references :survey
      t.timestamps
    end
  end
end
