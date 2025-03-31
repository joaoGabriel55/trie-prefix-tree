class FlagWordsService
    def initialize(text:, forbidden_words:)
        @forbidden_words = forbidden_words
        @trie = Trie.new(forbidden_words).freeze
        @words = text.split(' ').map(&:downcase)
    end

    attr_accessor :trie, :words, :forbidden_words

    def flag_words
        words.select { |word| trie.search(word) }
    end

    def flag_words_without_trie
        words.select { |word| forbidden_words.include?(word) }
    end
end
