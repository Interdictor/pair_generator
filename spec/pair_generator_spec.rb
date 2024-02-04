require_relative '../src/pair_generator'

RSpec.describe PairGenerator do
  context 'given only two people' do
    people = ['a', 'b']

    it 'generates a pair from a seed' do
      generator = PairGenerator.new
      seed = 0

      pair = generator.pair(people, seed)

      expected_result = [Set.new(['a', 'b'])]
      expect(pair).to eq(expected_result)
    end

    it 'generates the same pair ignoring the seed' do
      generator = PairGenerator.new

      cases = {
        0 => [Set.new(['a', 'b'])],
        1 => [Set.new(['a', 'b'])],
        2 => [Set.new(['a', 'b'])],
      }

      assert_cases(cases, generator, people)
    end
  end

  context 'given invalid seed' do
    people = ['a', 'b']

    it 'raises a InvalidSeedError for floats' do
      seed = 0.1
      generator = PairGenerator.new

      expect { generator.pair(people, seed) }.to(
        raise_exception(InvalidSeedError)
      )
    end

    it 'raises a InvalidSeedError for negative numbers' do
      seed = -1
      generator = PairGenerator.new

      expect { generator.pair(people, seed) }.to(
        raise_exception(InvalidSeedError)
      )
    end
  end

  context 'given four people' do
    people = ['a', 'b', 'c', 'd']

    it 'generates three different combinations' do
      generator = PairGenerator.new

      cases = {
        0 => [Set.new(['a', 'd']), Set.new(['b', 'c'])],
        1 => [Set.new(['a', 'b']), Set.new(['c', 'd'])],
        2 => [Set.new(['a', 'c']), Set.new(['d', 'b'])],
      }

      assert_cases(cases, generator, people)
    end

    it 'generates the same pairs for an equivalent seed' do
      generator = PairGenerator.new
      first_seed = 0
      second_seed = 3

      first_result = generator.pair(people, first_seed)
      second_result = generator.pair(people, second_seed)

      expect(first_result).to eq(second_result)
    end
  end


  context 'given six people' do
    people = ['a', 'b', 'c', 'd', 'e', 'f']

    it 'generates five different combinations' do
      generator = PairGenerator.new

      cases = {
        0 => [Set.new(['a', 'f']), Set.new(['b', 'e']), Set.new(['c', 'd'])],
        1 => [Set.new(['a', 'b']), Set.new(['c', 'f']), Set.new(['d', 'e'])],
        2 => [Set.new(['a', 'c']), Set.new(['d', 'b']), Set.new(['e', 'f'])],
        3 => [Set.new(['a', 'd']), Set.new(['e', 'c']), Set.new(['f', 'b'])],
        4 => [Set.new(['a', 'e']), Set.new(['f', 'd']), Set.new(['b', 'c'])],
        9 => [Set.new(['a', 'e']), Set.new(['f', 'd']), Set.new(['b', 'c'])],
      }

      assert_cases(cases, generator, people)
    end
  end

  context 'given a odd number of people' do
    people = ['a', 'b', 'c']

    it 'adds a null person to the combination' do
      generator = PairGenerator.new

      cases = {
        0 => [Set.new(['a', nil]), Set.new(['b', 'c'])],
        1 => [Set.new(['a', 'b']), Set.new(['c', nil])],
        2 => [Set.new(['a', 'c']), Set.new(['b', nil])],
        3 => [Set.new(['a', nil]), Set.new(['b', 'c'])],
        6 => [Set.new(['a', nil]), Set.new(['b', 'c'])],
        9 => [Set.new(['a', nil]), Set.new(['b', 'c'])],
      }

      assert_cases(cases, generator, people)
    end
  end

  def assert_cases(cases, generator, people)
    cases.each do |seed, expected_result|
      result = generator.pair(people, seed)
      expect(result).to(
        eq(expected_result),
        lambda { "Failed with seed: #{seed}" },
      )
    end
  end
end
