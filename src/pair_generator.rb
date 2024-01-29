class PairGenerator
  def pair(people, seed)
      primary_group = people.clone
      secondary_group = people.clone

      (seed + 1).times do
        secondary_group.push(secondary_group.shift)
      end

      edge = nil
      result = []
      already_included = Set.new

      # p '******'
      # p primary_group
      # p '------------'
      # p secondary_group
      # p '******'


      while primary_group.any?

        edge = toggle(edge)

        if seed.odd? && primary_group.size == 2
          first_person = primary_group.pop
          second_person = secondary_group.shift
        else
          first_person = primary_group.send(edge)
          second_person = secondary_group.send(edge)
        end

        thing = {
          first_person: first_person,
          second_person: second_person,
        }

        p thing



        next if already_included.include?(first_person) || already_included.include?(second_person)

        result.push(::Set.new([first_person, second_person]))
        already_included.add(first_person)
        already_included.add(second_person)
      end

      result
    end

    private

    def toggle(edge)
      if edge == :shift
        return :pop
      end

      :shift
    end
  end
