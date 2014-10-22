require_relative 'all_models.rb'

class QuestionFollower
  
  attr_reader :id, :follower_id, :followed_question_id

  def initialize(options = {})
    @id = options['id']
    @follower_id = options['follower_id']
    @followed_question_id = options['followed_question_id'] 
  end
  
  def self.followers_for_question_id(question_id)
    query = <<-SQL
    SELECT 
      u.id, u.fname, u.lname
    FROM 
      question_followers AS q 
    JOIN
      users AS u
    ON 
      u.id = q.follower_id
    WHERE
      followed_question_id = ?
    
    SQL
    
    hash = QuestionsDB.instance.execute(query, question_id)
    hash.map do |user_hash|
      User.new(user_hash)
    end
  end
  
  def self.most_followed_questions(n)
    query = <<-SQL
    SELECT
      q.id, q.title, q.body, q.user_id
    FROM
      questions AS q
    LEFT OUTER JOIN
      (SELECT
      followed_question_id, COUNT(follower_id) AS num
      FROM
      question_followers
      GROUP BY
      followed_question_id) f
    ON
      f.followed_question_id = q.id
    ORDER BY
      f.num DESC
    LIMIT ?
    SQL
    
    hash = QuestionsDB.instance.execute(query, n)
    hash.map do |question_hash|
      Question.new(question_hash)
    end   
  end
  
  def self.followed_questions_for_user_id(user_id)
    query = <<-SQL
    SELECT 
      q.id, q.title, q.body, q.user_id
    FROM 
      question_followers AS f 
    JOIN
      questions AS q
    ON 
      q.id = f.followed_question_id
    WHERE
      follower_id = ?
    
    SQL
    
    hash = QuestionsDB.instance.execute(query, user_id)
    hash.map do |question_hash|
      Question.new(question_hash)
    end
  end
  
  
  
  def self.find_by_id(id)
    query = <<-SQL
    SELECT
      *
    FROM
      question_followers
    WHERE
      id = ?
    SQL

    hash = QuestionsDB.instance.execute(query, id)
    self.new(hash.first)
  end
  

  
end