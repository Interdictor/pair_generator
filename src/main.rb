require_relative './pair_generator'

throw 'SEED env variable is required' if !ENV['SEED']
throw 'PEOPLE env variable is required' if !ENV['PEOPLE']

seed = ENV['SEED'].to_i
people = ENV['PEOPLE'].split(';')


result = PairGenerator.new.pair(people, seed)

result.each do |set|
  p "#{set.to_a[0]} - #{set.to_a[1]}"
end
