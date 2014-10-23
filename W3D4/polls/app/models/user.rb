# == Schema Information
#
# Table name: users
#
#  id        :integer          not null, primary key
#  user_name :string(255)      not null
#

class User < ActiveRecord::Base
  
  validates :user_name, presence: true, uniqueness: true
  
  has_many(
    :authored_polls,
    class_name: 'Poll',
    foreign_key: :author_id,
    primary_key: :id,
    dependent: :destroy
  )
  
  has_many(
    :responses,
    class_name: 'Response',
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )

  #
  # has_many(
  #   :answered_polls,
  #   through: :answered_questions,
  #   soruce: :poll
  # )
  
  
  def completed_polls
    # user_poll_responses = Poll
    # .joins('LEFT OUTER JOIN questions ON questions.poll_id = polls.id')
    # .joins('JOIN answer_choices ON answer_choices.question_id = questions.id')
    # .joins('RIGHT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
    # .where('responses.user_id = ?', self.id)
    # .group('polls.id')
    # .select('polls.id, COUNT(responses.id) AS total_answered')
    # .joins(:answered_polls)
    # .having('')
    
    Poll
      .joins(questions: :answer_choices)
      .joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
      .where('responses.user_id = ? OR responses.user_id IS NULL', self.id)
      .group('polls.id')
      .having('COUNT(DISTINCT(responses.id)) = COUNT(DISTINCT(questions.id))')
    
    # Poll.find_by_sql(<<-SQL)
#     SELECT
#     poll_questions.id
#     FROM
#     (SELECT
#       polls.id, COUNT(questions.id) AS total_questions
#       FROM
#       polls
#       JOIN
#       questions
#       ON
#       polls.id = questions.poll_id
#       GROUP BY
#       polls.id
#     ) poll_questions
#     LEFT OUTER JOIN
#     (
#       SELECT
#       polls.id, COUNT(responses.id) AS total_answered
#       FROM
#       polls
#       LEFT OUTER JOIN
#       questions
#       ON
#       questions.poll_id = polls.id
#       JOIN
#       answer_choices
#       ON
#       answer_choices.question_id = questions.id
#       RIGHT OUTER JOIN
#       responses
#       ON
#       responses.answer_choice_id = answer_choices.id
#       WHERE
#       responses.user_id = #{self.id}
#       GROUP BY
#       polls.id
#     ) user_poll_responses
#     ON
#     poll_questions.id = user_poll_responses.id
#
#     GROUP BY
#     poll_questions.id
#     HAVING
#     MAX(total_questions) = MAX(total_answered)
#     SQL


     
     # user_responses_per_poll =
#
#      user -> response -> question -> poll
#

     
  end
  
end
