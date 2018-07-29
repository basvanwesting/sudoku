class Sudoku::Game
  attr_accessor :cells, :rows, :columns, :areas

  def initialize(cells: [], rows: [], columns: [], areas: [])
    self.cells   = cells
    self.rows    = rows
    self.columns = columns
    self.areas   = areas
  end

  def update_cells
    rows.each(&:update_cells)
    columns.each(&:update_cells)
    areas.each(&:update_cells)
  end

  def next_cell
    initial_cell = cells.detect { |cell| cell.value.nil? }
    return unless initial_cell
    cells.reject(&:value).inject(initial_cell) do |selected_cell, working_cell|
      if working_cell.number_of_options < selected_cell.number_of_options
        working_cell
      else
        selected_cell
      end
    end
  end

  def solve
    update_cells
    while (new_cell = next_cell)
      allowed_values = new_cell.allowed_values
      break unless allowed_values.size == 1
      new_cell.value = allowed_values.first
      update_cells
    end
  end
end
