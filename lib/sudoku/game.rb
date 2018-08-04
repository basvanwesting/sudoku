class Sudoku::Game
  attr_accessor :cells, :rows, :columns, :areas
  attr_accessor :steps, :display_steps

  def initialize(cells: [], rows: [], columns: [], areas: [], display_steps: false)
    self.cells   = cells
    self.rows    = rows
    self.columns = columns
    self.areas   = areas
    self.steps   = []
    self.display_steps = display_steps
  end

  def solve
    Sudoku::Solve.new(self).call
  end

  def make_step(step)
    step.cell.value = step.value
    self.steps << step
    Sudoku::Display.new(self).redraw if display_steps
    step
  end

  def to_s
    Sudoku::Display.new(self).to_s
  end

  def containers
    [
      rows,
      columns,
      areas,
    ].flatten
  end

  def unsolved_cells
    cells.reject(&:value)
  end

  def solved?
    cells.all? { |cell| !cell.value.nil? }
  end

  class << self
    def from_matrix(matrix_values)
      matrix_cells = matrix_values.map.with_index do |row_values, row_position|
        row_values.map.with_index do |value, column_position|
          Sudoku::Cell.new(
            value,
            value_range: self::VALUE_RANGE,
            row_position: row_position,
            column_position: column_position,
          )
        end
      end

      rows = matrix_cells.map do |row_cells|
        Sudoku::Row.new(row_cells)
      end

      columns = matrix_cells[0].zip(*matrix_cells[1..-1]).map do |column_cells|
        Sudoku::Column.new(column_cells)
      end

      areas = []
      matrix_cells.each_slice(self::AREA_HEIGHT) do |sub_rows|
        groups = sub_rows.map do |cells|
          cells.each_slice(self::AREA_WIDTH).to_a
        end
        groups[0].zip(*groups[1..-1]).map do |area_cells|
          areas << Sudoku::Area.new(area_cells.flatten)
        end
      end

      new(
        cells:   matrix_cells.flatten,
        rows:    rows,
        columns: columns,
        areas:   areas,
      )
    end

    def from_heredoc(heredoc)
      from_matrix(
        heredoc.split("\n").map do |line|
          line.
            scan(/[\d\s\.]/).
            map(&:to_i).
            map { |v| v == 0 ? nil : v }
        end.reject(&:empty?)
      )
    end
  end
end
