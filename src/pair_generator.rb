require_relative './invalid_seed_error'

class PairGenerator
  LIST_START = 0
  LIST_END = -1
  OFFSET = 1

  def pair(given_people, given_seed)
    validate_seed!(given_seed)
    people = given_people.sort
    people.push(nil) if people.size.odd?
    seed = modularize_seed(given_seed, people)

    fixed_person = people.shift
    seed.times { people.push(people.shift) }
    people.unshift(fixed_person)

    first_group = generate_first_group(people)
    second_group = generate_second_group(people)
    result = []

    first_group.size.times do
      result.push(Set.new([first_group.shift, second_group.shift]))
    end

    return result
  end

  private

  def generate_first_group(people)
    midlist = calculate_midlist(people)

    people.slice(LIST_START..(midlist - OFFSET))
  end

  def generate_second_group(people)
    midlist = calculate_midlist(people)

    people.slice(midlist..LIST_END).reverse
  end

  def calculate_midlist(people)
    people.size / 2
  end

  def modularize_seed(seed, people)
    posible_combinations = people.size - 1
    seed % posible_combinations
  end

  def validate_seed!(seed)
    raise InvalidSeedError if (seed.class != Integer) || (seed < 0)
  end
end
