require_relative 'question'
require_relative 'super_question'

class Reply < SuperQuestion
  attr_accessor :body, :subject, :parent, :author

  def self.find_by_id(id)
    reply = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL

    return nil unless reply.length > 0
    Reply.new(reply.first)
  end

  def self.find_by_user_id(author)
    reply = QuestionsDB.instance.execute(<<-SQL, author)
      SELECT
        *
      FROM
        replies
      WHERE
        author = ?
    SQL

    return nil unless reply.length > 0
    Reply.new(reply.first)
  end

  def self.find_by_question_id(subject)
    replies = QuestionsDB.instance.execute(<<-SQL, subject)
      SELECT
        *
      FROM
        replies
      WHERE
        subject = ?
    SQL

    return nil unless replies.length > 0

    replies.map { |r| Reply.new(r) }
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @subject = options['subject']
    @parent = options['parent']
    @author = options['author']
  end

  def save
    if @id
      QuestionsDB.instance.execute(<<-SQL, @body, @subject, @parent, @author, @id)
        UPDATE
          replies
        SET
          body = ?, subject = ?, parent = ?, author = ?
        WHERE
          id = ?
      SQL
    else
      QuestionsDB.instance.execute(<<-SQL, @body, @subject, @parent, @author)
        INSERT INTO
          replies (body, subject, parent, author)
        VALUES
          (?, ?, ?, ?)
      SQL
      @id = QuestionsDB.instance.last_insert_row_id
    end
  end

  def author
    self.author
  end

  def question
    self.subject
  end

  def parent_reply
    reply = Reply.find_by_question_id(self.subject)
    reply.select { |r| r.parent.nil? }
  end

  def child_replies
    reply = Reply.find_by_question_id(self.subject)
    reply.select { |r| r.parent != nil }
  end
end

# options = {'id' => 4, 'body' => 'test', 'subject' => 2, 'parent' => 2, 'author' => 1}
# options2 = {'id' => 5, 'body' => 'test2', 'subject' => 1, 'parent' => 1, 'author' =>1}
 # test = Reply.new(options)
