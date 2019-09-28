module InsertRecords
  class Base
    attr_reader :form
    def initialize(form)
      # now: form = 0llDiH
      @form = form
    end

    def insert_times(times, step = 50)
      arr = Array.new( (times / step), step)
      arr << (times % step)

      arr.each {|i| insert(i)}
    end

    def insert(num)
      matches = []
      num.times do |i|
        matches << Match.new(match_params)
      end
      Match.import matches
    end

  end
end
