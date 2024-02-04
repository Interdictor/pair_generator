require_relative './round_robin_pair_generator'

raw_seed = ENV.fetch('SEED') { |arg| raise "Undefined #{arg} env variable"}
raw_people = ENV.fetch('PEOPLE') { |arg| raise "Undefined #{arg} env variable"}

seed = raw_seed.to_i
people = raw_people.split('|')

result = RoundRobinPairGenerator.new.pair(people, seed)

result.each do |set|
  p "#{set.to_a[0]} - #{set.to_a[1]}"
end
