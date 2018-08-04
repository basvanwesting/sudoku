require 'active_support/core_ext/module'
require 'active_support/core_ext/object'

require "sudoku/version"
require "sudoku/cell"
require "sudoku/cell"
require "sudoku/container"
require "sudoku/row"
require "sudoku/column"
require "sudoku/area"
require "sudoku/game"
require "sudoku/game/two_by_two"
require "sudoku/game/four_by_four"
require "sudoku/game/six_by_six_horizontal"
require "sudoku/game/nine_by_nine"
require "sudoku/solve_step"
require "sudoku/solve_step/using_open_single"
require "sudoku/solve_step/using_hidden_single"
require "sudoku/solve_step/using_open_double"
require "sudoku/solve"
require "sudoku/display"

module Sudoku
  if __FILE__ == $0
    sudoku = Sudoku::Game::NineByNine.from_heredoc <<~DOC
      ...|.3.|2..
      ..9|.4.|...
      31.|2..|...
      ---+---+---
      ...|3..|.5.
      .5.|1..|..6
      ...|...|.91
      ---+---+---
      4..|...|6..
      ..5|.84|...
      926|..7|..4
    DOC
    sudoku.display_steps = true
    sudoku.solve
  end
end

