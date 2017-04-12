class SuperQuestion
  def self.all(class_name, table_name)
    data = QuestionsDB.instance.execute("SELECT * FROM #{table_name}")
    data.map { |datum| class_name.new(datum) }
  end

  # def self.find_by_id(class_name, table_name, id)
  #   container = QuestionsDB.instance.execute(<<-SQL, table_name, id)
  #     SELECT
  #       *
  #     FROM
  #       table_name
  #     WHERE
  #       id = ?
  #   SQL
  #
  #   return nil unless container.length > 0
  #   class_name.new(container.first)
  # end
end
