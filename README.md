# Trie (prefix tree) in Ruby

A simple trie implementation in Ruby

How to run benchmarks:
```bash
bundle install
rails c

def generate_random_words(count = 1000)
    vowels = %w[a e i o u]
    consonants = %w[b c d f g h j k l m n p q r s t v w x y z]
    words = Set.new # Use Set to ensure uniqueness

    while words.size < count
        word = ""
        3.times do # Generate 3-syllable-like words
        word += consonants.sample + vowels.sample
        end
        words.add(word.downcase)
    end

    words.to_a
end

w = generate_random_words(1000).freeze
sample_text = (w[0..10] + ["hello", "world"] * 50).shuffle.join(" ")
s = FlagWordsService.new(text: sample_text)
s.benchmark_flag_words_methods # Run the benchmark. Defaults to 10_000 iterations
```