class Sudoku::Game::NineByNine < Sudoku::Game

  VALUE_RANGE = 1..9
  AREA_WIDTH = 3
  AREA_HEIGHT = 3

  def report(io = $stdout)
    line_width = VALUE_RANGE.size + (VALUE_RANGE.size / AREA_WIDTH) - 1
    rows.each_slice(AREA_HEIGHT) do |sub_rows|
      sub_rows.each do |cells|
        cells.each_slice(AREA_WIDTH) do |sub_cells|
          io.write sub_cells.map { |c| c.value || ' ' }.join('')
          io.write '|'
        end
        io.seek(io.pos - 1)
        io.truncate(io.pos)
        io.puts
      end
      io.write '-'*line_width
      io.puts
    end
    io.seek(io.pos - line_width - 1)
    io.truncate(io.pos)
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

      areas = []
      matrix_cells.each_slice(AREA_HEIGHT) do |sub_rows|
        groups = sub_rows.map do |cells|
          cells.each_slice(AREA_WIDTH).to_a
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
  end

end
