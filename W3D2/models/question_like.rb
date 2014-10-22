require_relative 'all_models.rb'

class QuestionLike
  attr_reader :id, :user_id, :question_id
  
  def initialize(options = {})
    @id = options['id']
    @question_id = options['question_id']
    @user_id = options['user_id'] 
  end

  def self.most_liked_questions(n)
    query = <<-SQL
    SELECT
      q.id, q.body, q.title, q.user_id
    FROM
      questions q
    LEFT OUTER JOIN
      (SELECT 
        question_id, COUNT(user_id) AS num
      FROM 
        question_likes
      GROUP BY 
        question_id) f
    ON
      f.question_id = q.id
    ORDER BY
      f.num DESC 
    LIMIT 
      ?
    
    SQL
    
    hash = QuestionsDB.instance.execute(query, n)
    hash.map do |question_hash|
      Question.new(question_hash)
    end 
  end
  
  def self.likers_for_question_id(question_id)
    query = <<-SQL
    SELECT
      u.id, u.fname, u.lname
    FROM
      question_likes AS l
    JOIN
      users AS u
    ON
      u.id = l.user_id
    WHERE
      question_id = ?
    SQL
    
    hash = QuestionsDB.instance.execute(query, question_id)
    hash.map do |user_hash|
      User.new(user_hash)
    end
  end
  
  def self.liked_questions_for_user_id(user_id)
    query = <<-SQL
    SELECT
      q.id, q.title, q.body, q.user_id
    FROM
      question_likes AS l
    JOIN
      questions AS q
    ON
      l.question_id = q.id
    WHERE
      l.user_id = ?
    SQL
    
    hash = QuestionsDB.instance.execute(query, user_id)
    hash.map do |question_hash|
      Question.new(question_hash)
    end
  end
  
  def self.num_likes_for_question_id(question_id)
    query = <<-SQL
    SELECT
      COUNT(user_id) AS num
    FROM
      question_likes
    WHERE question_id = ?
    GROUP BY 
      question_id

    SQL
    hash = QuestionsDB.instance.execute(query, question_id)
    return 0 if hash.empty?
    hash.first["num"]
  end
  
  def self.find_by_id(id)
    query = <<-SQL
    SELECT
      *
    FROM
      question_likes
    WHERE
      id = ?
    SQL

    hash = QuestionsDB.instance.execute(query, id)
    self.new(hash.first)
  end
end