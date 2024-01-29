require_relative '../src/pair_generator'

RSpec.describe PairGenerator do
  context 'given only two people' do
    people = ['a', 'b']

    it 'generates the same pair ignoring the seed' do
      generator = PairGenerator.new

      cases = {
        0 => [Set.new(['a', 'b'])],
        1 => [Set.new(['a', 'b'])],
        2 => [Set.new(['a', 'b'])],
      }
      cases.each do |seed, expected_result|
        result = generator.pair(people, seed)
        expect(result).to(
          eq(expected_result),
          lambda { "Failed with seed: #{seed}" },
        )
      end
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
      cases.each do |seed, expected_result|
        result = generator.pair(people, seed)
        expect(result).to(
          eq(expected_result),
          lambda { "Failed with seed: #{seed}" },
        )
      end
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
      }
      cases.each do |seed, expected_result|
        result = generator.pair(people, seed)
        expect(result).to(
          eq(expected_result),
          lambda { "Failed with seed: #{seed}" },
        )
      end
    end
  end
end
