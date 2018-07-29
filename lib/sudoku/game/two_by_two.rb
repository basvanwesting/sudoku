class Sudoku::Game::TwoByTwo < Sudoku::Game

  def report(io = $stdout)
    io.puts(
      rows.map do |row|
        row.map(&:value).join('|')
      end.join("\n---\n")
    )
    io
  end

  class << self
    def from_matrix(matrix_values)
      matrix_cells = matrix_values.map do |row_values|
        row_values.map do |value|
          Sudoku::Cell.new(value)
        end
      end

      rows = matrix_cells.map do |row_cells|
        Sudoku::Row.new(row_cells)
      end

      columns = matrix_cells[0].zip(matrix_cells[1..-1]).map do |column_cells|
        Sudoku::Column.new(column_cells)
      end

      new(
        cells:   matrix_cells.flatten,
        rows:    rows,
        columns: columns,
        areas:   [],
      )
    end
  end

end
