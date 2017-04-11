require 'sqlite3'
require 'singleton'
require_relative 'reply'

class QuestionsDB < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question
  attr_accessor :title, :body, :author

  def self.all
    data = QuestionsDB.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
  end

  def self.find_by_id(id)
    question = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        questions
      WHERE
        id = ?
    SQL

    return nil unless question.length > 0
    Question.new(question.first)
  end

  def self.find_by_author_id(author_id)
    question = QuestionsDB.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    return nil unless question.length > 0
    Question.new(question.first)
  end

  def self.most_followed(n)
    QuestionFollow.most_followed_questions(n)
  end

  def self.most_liked(n)
    QuestionLike.most_liked_questions(n)
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author = options['author']
  end

  def save
    if @id
      QuestionsDB.instance.execute(<<-SQL, @title, @body, @author, @id)
        UPDATE
          questions
        SET
          title = ?, body = ?, author = ?
        WHERE
          id = ?
      SQL
    else
      QuestionsDB.instance.execute(<<-SQL, @title, @body, @author)
        INSERT INTO
          questions (title, body, author)
        VALUES
          (?, ?, ?)
      SQL
      @id = QuestionsDB.instance.last_insert_row_id
    end
  end

  def author
    self.author
  end

  def replies
    Reply.find_by_question_id(self.id)
  end

  def followers
    QuestionFollow.followers_for_question_id(self.id)
  end

  def likers
    QuestionLike.likers_for_question_id(self.id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(self.id)
  end
end
