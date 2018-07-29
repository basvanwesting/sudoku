class Sudoku::Game
  attr_accessor :cells, :rows, :columns, :areas

  def initialize(cells: [], rows: [], columns: [], areas: [])
    self.cells   = cells
    self.rows    = rows
    self.columns = columns
    self.areas   = areas
  end
end
