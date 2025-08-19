class RadixNode
  def initialize(prefix = "")
    @children = {}
    @prefix = prefix
    @is_end_of_word = false
  end

  attr_accessor :children, :prefix, :is_end_of_word
end

class Radix
  def initialize(words = nil)
    @root = RadixNode.new

    words&.each { |word| insert(word) }
  end

  def insert(word)
    insert_recursive(@root, word)
  end

  def search(word)
    search_recursive(@root, word)
  end

  private

  # Helper method to find the longest common prefix between two strings
  def common_prefix_length(str1, str2)
    min_length = [str1.length, str2.length].min
    i = 0
    i += 1 while i < min_length && str1[i] == str2[i]
    i
  end

  def insert_recursive(node, word)
    return if word.empty?

    if node.prefix.empty?
      first_char = word[0]
      if node.children.key?(first_char)
        insert_recursive(node.children[first_char], word)
      else
        new_node = RadixNode.new(word)
        new_node.is_end_of_word = true
        node.children[first_char] = new_node
      end

      return
    end

    common_len = common_prefix_length(node.prefix, word)
    common = node.prefix[0, common_len]

    if common_len == node.prefix.length
      # Current node's prefix is fully matched
      remaining = word[common_len..-1] || ""
      if remaining.empty?
        node.is_end_of_word = true
      else
        first_char = remaining[0]
        if node.children.key?(first_char)
          insert_recursive(node.children[first_char], remaining)
        else
          new_node = RadixNode.new(remaining)
          new_node.is_end_of_word = true
          node.children[first_char] = new_node
        end
      end
    else
      # Split the current node
      remaining_node_prefix = node.prefix[common_len..-1]
      remaining_word = word[common_len..-1] || ""

      # Update current node to common prefix
      new_node = RadixNode.new(common)
      new_node.is_end_of_word = false
      new_child = RadixNode.new(remaining_node_prefix)
      new_child.is_end_of_word = node.is_end_of_word
      new_child.children = node.children

      # Replace current node's content
      node.prefix = common
      node.is_end_of_word = false
      node.children = {}
      node.children[remaining_node_prefix[0]] = new_child

      # Add remaining word if it exists
      unless remaining_word.empty?
        new_word_node = RadixNode.new(remaining_word)
        new_word_node.is_end_of_word = true
        node.children[remaining_word[0]] = new_word_node
      end
    end
  end

  def search_recursive(node, word)
    # Base case: if word is empty, check if current node marks end of a word
    return node.is_end_of_word if word.empty?

    if node.prefix.empty?
      first_char = word[0]
      return node.children.key?(first_char) ? search_recursive(node.children[first_char], word) : false
    end

    # Find length of common prefix
    common_len = common_prefix_length(node.prefix, word)
    return false if common_len != node.prefix.length

    # If the entire word matches the prefix
    if word.length == common_len
      return node.is_end_of_word
    end

    # Recurse into child with matching first character
    remaining = word[common_len..-1]
    first_char = remaining[0]
    return false unless node.children.key?(first_char)
    search_recursive(node.children[first_char], remaining)
  end
end
