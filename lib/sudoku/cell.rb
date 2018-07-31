class Sudoku::Cell
  attr_accessor :value, :denied_values, :value_range

  def initialize(value = nil, value_range:, denied_values: [])
    self.value         = value
    self.denied_values = denied_values
    self.value_range   = value_range.to_a
  end

  def deny_value(value)
    return if denied_values.include?(value)
    self.denied_values << value
  end

  def number_of_options
    allowed_values.size
  end

  def allowed_values
    return [value] if value.present?
    value_range - denied_values
  end

  def deny_values(values)
    values.each do |value|
      deny_value(value)
    end
  end

end
