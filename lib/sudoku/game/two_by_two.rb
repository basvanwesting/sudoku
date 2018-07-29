class Sudoku::Game::TwoByTwo < Sudoku::Game

  VALUE_RANGE = 1..2

  def report(io = $stdout)
    io.puts(
      rows.map do |row|
        row.
          map { |cell| cell.value || " " }.
          join('|')
      end.join("\n---\n")
    )
    io
  end

  class << self
    def from_matrix(matrix_values)
      matrix_cells = matrix_values.map do |row_values|
        row_values.map do |value|
          Sudoku::Cell.new(value, value_range: VALUE_RANGE)
        end
      end

      rows = matrix_cells.map do |row_cells|
        Sudoku::Row.new(row_cells)
      end

      columns = matrix_cells[0].zip(*matrix_cells[1..-1]).map do |column_cells|
        Sudoku::Column.new(column_cells)
      end

      new(
        cells:   matrix_cells.flatten,
        rows:    rows,
        columns: columns,
      )
    end
  end

end
