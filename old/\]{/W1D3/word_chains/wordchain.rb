require 'byebug'
require 'set'

class WordChainer

  attr_reader :dictionary
  attr_accessor :current_words, :all_seen_words

  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map(&:chomp))
  end

  def adjacent_words(target)
    dictionary.select do |word|
      miss = 0
      word.length.times do |i|
        miss += 1 if word[i] != target[i]
      end
      miss == 1 && target.length == word.length
    end
  end

  def run(source, target)
    @current_words = source
    @all_seen_words = source

    until current_words.empty?
      new_current_words = []

    end

  end

end

if __FILE__ == $PROGRAM_NAME
  word = WordChainer.new('dictionary.txt')
  p word.dictionary
  p word.adjacent_words('caddy')
end
