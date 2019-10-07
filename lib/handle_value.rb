class HandleValue
  attr_accessor :compiled_value
  attr_reader :value
  def initialize(value)
    @value = value
    @compiled_value ||= ""
  end

  def set_value
    if value_is_address?
      compiled_value = value.values.join(" ")
    else
      compiled_value = value
    end
  end

  def value_is_address?
    value.is_a?(Hash) && value.keys.first.match(/province/)
  end
end
