require_relative 'all_models.rb'

class User
  include Models
  
  attr_reader :id
  attr_accessor :fname, :lname
  
  def initialize(options = {})
    @fname = options['fname']
    @lname = options['lname']
    @id = options['id']
  end
  
  def table_name
    "users"
  end
  
  def ask_question!(title, body)
    Question.new({'title'=> title, 'body' => body, 'user_id' => @id}).save
  end
  
  def edit_question(question_id, title, body)
    raise unless Question.find_by_id(question_id).user_id == @id
    Question.new({'id'=>question_id, 'title'=> title, 'body' => body, 'user_id' => @id}).save
  end
  
  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end
  
  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end
  
  def average_karma
    query = <<-SQL
    SELECT 
      SUM(f.num_likes) / CAST(COUNT(q.id) AS FLOAT ) AS average_karma
    FROM
      questions q
    LEFT OUTER JOIN
      (SELECT
      question_id, COUNT(user_id) AS num_likes
      FROM
      question_likes
      GROUP BY 
      question_id) f
      ON q.id = f.question_id
    WHERE 
    q.user_id = ?
    SQL
    
    hash = QuestionsDB.instance.execute(query, @id)
    hash.first["average_karma"]
    
  end
  
  
  def self.all
    query = <<-SQL
    SELECT 
    * 
    FROM 
    users
    SQL
    
    hash = QuestionsDB.instance.execute(query)
    hash.map do |users_hash|
      self.new(users_hash)
    end
  end

  def self.find_by_id(id)
    query = <<-SQL
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL

    hash = QuestionsDB.instance.execute(query, id)
    self.new(hash.first)
  end
  
  def self.find_by_name(fname, lname)
    query = <<-SQL
    SELECT
      *
    FROM
      users
    WHERE
      fname = ? AND lname = ? 
    SQL
    
    hash = QuestionsDB.instance.execute(query, fname, lname)
    self.new(hash.first) 
  end
  
  def authored_questions
    Question.find_by_author_id(@id)
  end
  
  def authored_replies
    Reply.find_by_user_id(@id)
  end
end