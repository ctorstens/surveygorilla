class CreateCompletions < ActiveRecord::Migration
  def change
    create_table :completions do |t|
      t.references :user
      t.references :survey
    end
  end
end
