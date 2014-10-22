require_relative 'all_models.rb'

class Question
  include Models
  
  attr_reader :id, :user_id
  attr_accessor :title, :body

  def initialize(options={})
    @title = options['title']
    @body = options['body']
    @user_id = options['user_id']
    @id = options['id']
  end
  
  def table_name
    "questions"
  end
  
  def likers
    QuestionLike.likers_for_question_id(@id)
  end
  
  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end
  
  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end
  
  def followers
    QuestionFollower.followers_for_question_id(@id)
  end
  
  def self.most_followed(n)
    QuestionFollower.most_followed_questions(n)
  end
  
  def self.all
    query = <<-SQL
    SELECT 
    * 
    FROM 
    questions
    SQL
    
    hash = QuestionsDB.instance.execute(query)
    hash.map do |questions_hash|
      self.new(questions_hash)
    end
  end
  

  
  
  def author
    query = <<-SQL
    SELECT
      *
    FROM
      users
    WHERE
      id = ?
    SQL
    
    hash = QuestionsDB.instance.execute(query, @user_id)
    User.new(hash.first)
  end
  
  def replies
    Reply.find_by_question_id(@id)
  end
  
  
  def self.find_by_id(id)
    query = <<-SQL
    SELECT
      *
    FROM
      questions
    WHERE
      id = ?
    SQL

    hash = QuestionsDB.instance.execute(query, id)
    self.new(hash.first)
  end
  
  def self.find_by_author_id(author_id)
    query = <<-SQL
    SELECT
      *
    FROM
      questions
    WHERE
      questions.user_id = ?
    SQL
    
    hash = QuestionsDB.instance.execute(query, author_id)
    hash.map do |question_hash|
      Question.new(question_hash)
    end
  end
  
  
  
end