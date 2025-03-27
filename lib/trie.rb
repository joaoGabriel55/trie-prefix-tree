class TrieNode
    def initialize
        @children = {}
        @is_end_of_word = false
    end

    attr_accessor :children, :is_end_of_word
end

class Trie
    def initialize(words = nil)
        @root = TrieNode.new

        words&.each { |word| insert(word) }
    end

    def insert(word)
        node = @root
        word.each_char do |char|
            node = node.children[char] ||= TrieNode.new
        end
        node.is_end_of_word = true
    end

    def search(word)
        node = @root
        word.each_char do |char|
            return false unless (node = node.children[char])
        end
        node.is_end_of_word
    end

    def starts_with(prefix)
        node = @root
        prefix.each_char do |char|
            return false unless node.children[char]
            node = node.children[char]
        end
        true
    end

    def show
        @root.children.each do |char, node|
            print "#{char}: "
            print node.children.keys
            print "\n"
        end
    end
end
