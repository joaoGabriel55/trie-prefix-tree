# Trie (prefix tree) in Ruby

A simple trie implementation in Ruby

How to run benchmarks:
```bash
bundle install
rails c

FlagWordsBenchmark.benchmark_flag_words_methods
# Default values
# runs: 1_000, words_number: 1_000, forbidden_words_number: 10_000
# Example usage with custom values:
FlagWordsBenchmark.benchmark_flag_words_methods(runs: 500, words_number: 600, forbidden_words_number: 10_000)
```