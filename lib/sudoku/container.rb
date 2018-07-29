class Sudoku::Container
  include Enumerable
  attr_accessor :cells

  def initialize(cells)
    self.cells = cells
  end

  def update_cells
    denied_values = cells.map { |cell| cell.value }.compact
    cells.each do |cell|
      cell.add_denied_values(denied_values)
    end
  end

  def each(&block)
    #cells.each(&block)
    cells.each do |cell|
      block.call(cell)
    end
  end
end
