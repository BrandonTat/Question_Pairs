require_relative 'question'
require_relative 'user'
require_relative 'super_question'

class QuestionLike < SuperQuestion
  attr_accessor :liker, :liked

  def self.likers_for_question_id(question_id)
    likers = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        question_likes
      JOIN
        users ON question_likes.liker = users.id
      WHERE
        question_likes.liked = ?
    SQL

    likers.map { |l| User.new(l) }
  end

  def self.num_likes_for_question_id(question_id)
    likes = QuestionsDB.instance.execute(<<-SQL, question_id)
      SELECT
        COUNT(*)
      FROM
        question_likes
      JOIN
        users ON question_likes.liker = users.id
      WHERE
        question_likes.liked = ?
    SQL

    likes.first.values.first
  end

  def self.liked_questions_for_user_id(user_id)
    liked_questions = QuestionsDB.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        question_likes
      JOIN
        questions ON question_likes.liked = questions.id
      WHERE
        question_likes.liker = ?
    SQL

    liked_questions.map { |question| Question.new(question) }
  end

  def self.most_liked_questions(n)
    questions = QuestionsDB.instance.execute(<<-SQL, n)
      SELECT
        *
      FROM
        question_likes
      JOIN questions ON questions.id = question_likes.liked
      GROUP BY
        questions.id
      ORDER BY
        COUNT(*) DESC
      LIMIT ?
    SQL

    questions.map { |q| Question.new(q) }
  end

  def initialize(options)
    @id = options['id']
    @liker = options['liker']
    @liked = options['liked']
  end
end
