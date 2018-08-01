class Sudoku::Cell
  attr_accessor :value, :denied_values, :value_range
  attr_accessor :row_position, :column_position

  def initialize(value = nil, value_range:, denied_values: [], row_position: nil, column_position: nil)
    self.value           = value
    self.denied_values   = denied_values
    self.value_range     = value_range.to_a
    self.row_position    = row_position
    self.column_position = column_position
  end

  def deny_value(value)
    return if denied_values.include?(value)
    self.denied_values << value
  end

  def deny_values(values)
    values.each do |value|
      deny_value(value)
    end
  end

  def allowed_values
    return [value] if value.present?
    value_range - denied_values
  end

  def number_of_options
    allowed_values.size
  end

  def coordinates
    [
      row_position,
      column_position,
    ]
  end

end
