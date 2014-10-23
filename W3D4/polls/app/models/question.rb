# == Schema Information
#
# Table name: questions
#
#  id      :integer          not null, primary key
#  text    :text
#  poll_id :integer
#

class Question < ActiveRecord::Base
  
  validates :text, presence: true
  validates :poll_id, presence: true
  
  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id  
  )
  
  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id,
    dependent: :destroy
  )
  
  has_many(
    :responses,
    through: :answer_choices,
    source: :responses,
    dependent: :destroy
  )

  def results
   answers = answer_choices.select('answer_choices.*, COUNT(responses.user_id)')
   .joins('LEFT OUTER JOIN responses ON answer_choices.id = responses.answer_choice_id')
   .where('answer_choices.question_id = ?', self.id)
   .group('answer_choices.id')
   answer_counts = {}
   answers.each do |answer|
     answer_counts[answer.text] = answer.responses.length
   end
   
   answer_counts
   
   # SELECT answer_choices.*, COUNT(responses.user_id)
   # FROM questions
   # JOIN answer_choices
   # ON questions.id = answer_choices.question_id
   # LEFT OUTER JOIN responses
   # ON answer_choices.id = responses.answer_choice_id
   # WHERE questions.id = self.id
   # GROUP BY responses.answer_choice_id


  end
end
