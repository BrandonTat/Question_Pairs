require_relative 'question'

class QuestionLike
  attr_accessor :liker, :liked

  def self.all
    data = QuestionsDB.instance.execute("SELECT * FROM question_likes")
    data.map { |datum| QuestionLike.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @liker = options['liker']
    @liked = options['liked']
  end
end
