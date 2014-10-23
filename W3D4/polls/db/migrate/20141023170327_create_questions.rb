class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.integer :poll_id
    end
    
    add_index :questions, :poll_id
  end
end
