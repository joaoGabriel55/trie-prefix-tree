# Trie (prefix tree) in Ruby

A simple trie implementation in Ruby

How to run benchmarks:
```bash
bundle install
rails c
```
Example usage with default params
```rb
FlagWordsBenchmark.benchmark_flag_words_methods
```
**Default params**
- `runs: 1_000`;
- `words_number: 1_000`;
- `forbidden_words_number: 10_000`.

**Example usage with custom values:**
```rb
FlagWordsBenchmark.benchmark_flag_words_methods(runs: 500, words_number: 600, forbidden_words_number: 10_000)
```
