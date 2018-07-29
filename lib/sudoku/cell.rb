class Sudoku::Cell
  attr_accessor :value, :denied_values

  def initialize(value = nil, denied_values: [])
    self.value = value
    self.denied_values = denied_values
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
    (1..9) - denied_values
  end

  def add_denied_values(new_denied_values)
    new_denied_values.each do |new_denied_value|
      deny_value(new_denied_value)
    end
  end

end
