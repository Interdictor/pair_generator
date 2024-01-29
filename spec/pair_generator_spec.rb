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
end
