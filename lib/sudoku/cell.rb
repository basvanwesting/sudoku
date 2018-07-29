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
    return [] if value.present?
    value_range - denied_values
  end

  def add_denied_values(new_denied_values)
    new_denied_values.each do |new_denied_value|
      deny_value(new_denied_value)
    end
  end

end
