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

class FlagWordsBenchmark
  def self.benchmark_flag_words_methods(runs: 1_000, words_number: 1_000, forbidden_words_number: 10_000)
    text = generate_random_words(words_number).join(' ')
    forbidden_words = generate_random_words(forbidden_words_number)

    service = FlagWordsService.new(text:, forbidden_words:)

    # Arrays to store execution times
    trie_times = []
    array_times = []

    puts "Running benchmark with #{runs} iterations..."

    # Benchmark flag_words (with Trie)
    trie_total = Benchmark.measure do
      runs.times do
        start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        service.flag_words
        end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        trie_times << (end_time - start_time)
      end
    end

    # Benchmark flag_words_without_trie (without Trie)
    array_total = Benchmark.measure do
      runs.times do
        start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        service.flag_words_without_trie
        end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC)
        array_times << (end_time - start_time)
      end
    end

    # Calculate averages
    trie_avg = trie_times.sum / runs
    array_avg = array_times.sum / runs

    # Output results
    puts "\nResults:"
    puts "flag_words (Trie):"
    puts "  Total time: #{trie_total.real.round(6)} seconds"
    puts "  Average time per run: #{trie_avg.round(9)} seconds"
    puts "flag_words_without_trie (Array):"
    puts "  Total time: #{array_total.real.round(6)} seconds"
    puts "  Average time per run: #{array_avg.round(9)} seconds"
  end
end
