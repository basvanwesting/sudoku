class Sudoku::Container
  include Enumerable
  attr_accessor :cells

  def initialize(cells)
    self.cells = cells
  end

  def each(&block)
    cells.each(&block)
  end
end
