# == Schema Information
#
# Table name: responses
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  answer_choice_id  :integer
#

class Response < ActiveRecord::Base
  
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :author_cannot_answer_own_question
  
  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id  
  )
  
  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )
  
  has_one(
    :question,
    through: :answer_choice,
    source: :question 
  )
  
  def sibling_responses
    question.responses
    .where(<<-SQL, self.user_id)
    responses.id IS NOT NULL AND 
    responses.user_id = ?
    SQL
    
  end
  
  def respondent_has_not_already_answered_question
    unless sibling_responses.length == 0 || (sibling_responses.length == 1 and sibling_responses.first == self)
      errors[:already_answered] << "the question"      
    end
  end
  
  def author_cannot_answer_own_question
    if question.poll.author_id == self.user_id
      errors[:cant_rig] << "own poll"
    end
  end
end
