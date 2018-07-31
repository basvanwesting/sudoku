class Sudoku::Solve
  attr_accessor :sudoku

  def initialize(sudoku)
    self.sudoku = sudoku
  end

  def call
    return if sudoku.solved?
    Sudoku::SolveStep::UsingOpenSingle.new(sudoku).call ||
      Sudoku::SolveStep::UsingHiddenSingle.new(sudoku).call ||
      Sudoku::SolveStep::UsingOpenDouble.new(sudoku).call
  end

end
