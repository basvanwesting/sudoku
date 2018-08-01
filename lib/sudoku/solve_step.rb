class Sudoku::SolveStep
  attr_accessor :sudoku
  attr_accessor :cell, :value

  def initialize(sudoku)
    self.sudoku = sudoku
  end

  def call
    apply if next_step
  end

  def apply
    self.cell.value = self.value
  end

  def next_step
    raise 'implement in including class'
  end

  def solved?
    sudoku.solved?
  end

  def cells
    sudoku.cells
  end

  def unsolved_cells
    sudoku.unsolved_cells
  end

  def containers
    sudoku.containers
  end
end
