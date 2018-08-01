class Sudoku::Solve
  attr_accessor :sudoku

  def initialize(sudoku)
    self.sudoku = sudoku
  end

  def call
    solve
  end

  def solve
    return if sudoku.solved?
    (
      solve_step_using_open_single ||
      solve_step_using_hidden_single ||
      solve_step_using_open_double
    ) && solve
  end

  def solve_step_using_open_single
    Sudoku::SolveStep::UsingOpenSingle.new(sudoku).call
  end

  def solve_step_using_hidden_single
    Sudoku::SolveStep::UsingHiddenSingle.new(sudoku).call
  end

  def solve_step_using_open_double
    Sudoku::SolveStep::UsingOpenDouble.new(sudoku).call
  end

end
