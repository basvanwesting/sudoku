class Sudoku::Game
  attr_accessor :cells, :rows, :columns, :areas

  def initialize(cells: [], rows: [], columns: [], areas: [])
    self.cells              = cells
    self.rows               = rows
    self.columns            = columns
    self.areas              = areas
  end

  def update_cells
    rows.each(&:update_cells)
    columns.each(&:update_cells)
    areas.each(&:update_cells)
  end

  def solve
    return if solved?
    update_cells
    solve_by_deny || solve_by_must
  end

  def solved?
    cells.all? { |cell| !cell.value.nil? }
  end

  def solve_by_deny
    cell, value = next_cell_for_solve_by_deny
    if cell && value
      cell.value = value
      solve
    end
  end

  def next_cell_for_solve_by_deny
    cells.reject(&:value).each do |cell|
      if cell.allowed_values.size == 1
        return [cell, cell.allowed_values.first]
      end
    end
    nil
  end

  def solve_by_must
    cell, value = next_cell_for_solve_by_must
    if cell && value
      cell.value = value
      solve
    end
  end

  def next_cell_for_solve_by_must
    (rows + columns + areas).each do |container|
      hash = Hash.new { |h,k| h[k] = [] }
      container.cells.reject(&:value).each do |cell|
        cell.allowed_values.each do |allowed_value|
          hash[allowed_value] << cell
        end
      end
      hash.each do |value, cells|
        if cells.size == 1
          return [cells.first, value]
        end
      end
    end
    nil
  end

  def report(io = $stdout)
    areas_per_line = self.class::VALUE_RANGE.size / self.class::AREA_WIDTH
    line_width = self.class::VALUE_RANGE.size + areas_per_line - 1
    rows.each_slice(self.class::AREA_HEIGHT) do |sub_rows|
      sub_rows.each do |cells|
        cells.each_slice(self.class::AREA_WIDTH) do |sub_cells|
          io.write sub_cells.map { |c| c.value || '.' }.join('')
          io.write '|'
        end
        io.seek(io.pos - 1) && io.truncate(io.pos)
        io.puts
      end
      areas_per_line.times do
        io.write '-' * self.class::AREA_WIDTH
        io.write '+'
      end
      io.seek(io.pos - 1) && io.truncate(io.pos)
      io.puts
    end
    io.seek(io.pos - line_width - 1) && io.truncate(io.pos)
    io
  end

  class << self
    def from_matrix(matrix_values)
      matrix_cells = matrix_values.map do |row_values|
        row_values.map do |value|
          Sudoku::Cell.new(value, value_range: self::VALUE_RANGE)
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
