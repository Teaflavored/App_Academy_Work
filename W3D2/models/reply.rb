require_relative 'all_models.rb'

class Reply
  include Models
  attr_reader :id, :subject_question_id, :parent_reply_id, :user_id
  attr_accessor :body
  
  def initialize(options = {})
    @body = options['body']
    @subject_question_id = options['subject_question_id']
    @parent_reply_id = options['parent_reply_id']
    @user_id = options['user_id'] 
    @id = options['id']
  end
  
  def table_name
    "replies"
  end
  
  def self.all
    query = <<-SQL
    SELECT 
    * 
    FROM 
    replies
    SQL
    
    hash = QuestionsDB.instance.execute(query)
    hash.map do |reply_hash|
      self.new(reply_hash)
    end
  end
  
  def self.find_by_id(id)
    query = <<-SQL
    SELECT
      *
    FROM
      replies
    WHERE
      id = ?
    SQL

    hash = QuestionsDB.instance.execute(query, id)
    self.new(hash.first)
  end
  
  def self.find_by_question_id(question_id)
    query = <<-SQL
    SELECT
      *
    FROM
      replies
    WHERE
      subject_question_id = ?
    SQL

    hash = QuestionsDB.instance.execute(query, question_id)
    hash.map do |reply_hash|
      self.new(reply_hash)
    end
  end
  
  def self.find_by_user_id(user_id)
    query = <<-SQL
    SELECT
    *
    FROM
    replies
    WHERE
    user_id = ?
    SQL
    
    hash = QuestionsDB.instance.execute(query, user_id)
    hash.map do |reply_hash|
      self.new(reply_hash)
    end
  end
  
  def author
    query = <<-SQL
    SELECT
    *
    FROM
    users
    WHERE
    users.id = ?
    SQL
    
    hash = QuestionsDB.instance.execute(query, @user_id)
    User.new(hash.first)
  end
  
  def question
    query = <<-SQL
    SELECT
    *
    FROM
    questions
    WHERE
    questions.id = ?
    SQL
    
    hash = QuestionsDB.instance.execute(query, @subject_question_id)
    Question.new(hash.first)
  end
  
  def parent_reply
    return nil if @parent_reply_id.nil?
    
    query = <<-SQL
    SELECT
    *
    FROM
    replies
    WHERE
    replies.id = ?
    SQL
    
    hash = QuestionsDB.instance.execute(query, @parent_reply_id)
    Reply.new(hash.first)
  end
  
  def child_replies
    query = <<-SQL
    SELECT
    *
    FROM
    replies
    WHERE
    parent_reply_id = ?
    SQL
    
    hash = QuestionsDB.instance.execute(query, @id)
    hash.map do |reply_hash|
      Reply.new(reply_hash)
    end
  end
  
end