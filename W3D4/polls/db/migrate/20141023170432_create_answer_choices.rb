class CreateAnswerChoices < ActiveRecord::Migration
  def change
    create_table :answer_choices do |t|
      t.text :text
      t.integer :question_id
    end
    
    add_index :answer_choices, :question_id
  end
end
