require_relative 'question'
require_relative 'user'

class QuestionFollow
  attr_accessor :users_id, :questions_id

  def self.all
    data = QuestionsDB.instance.execute("SELECT * FROM question_follows")
    data.map { |datum| QuestionFollow.new(datum) }
  end

  def self.find_by_id(id)
    questionfollow = QuestionsDB.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        id = ?
    SQL

    return nil unless questionfollow.length > 0
    QuestionFollow.new(questionfollow.first)
  end

  def self.followers_for_question_id(question_id)
    followers = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_follows
      JOIN users ON users.id = question_follows.users_id
      JOIN questions ON questions.id = question_follows.questions_id
      WHERE
        question_follows.questions_id = ?

    SQL

    followers.map { |f| User.new(f) }
  end

  def self.followed_questions_for_user_id(user_id)
    questions = QuestionsDB.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_follows
      JOIN
        users ON users.id = question_follows.users_id
      JOIN
        questions ON questions.id = question_follows.questions_id
      WHERE
        question_follows.users_id = ?
    SQL

    questions.map { |question| Question.new(question) }
  end

  def initialize(options)
    @id = options['id']
    @users_id = options['users_id']
    @questions_id = options['questions_id']
  end
end
