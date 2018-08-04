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
require "sudoku/game/six_by_six_vertical"
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
      6..|...|287
      .5.|.2.|.94
      ...|8..|6.1
      ---+---+---
      1.4|...|9.6
      8.6|94.|.3.
      .3.|762|..8
      ---+---+---
      2.7|39.|815
      .85|.1.|.63
      3..|...|...
    DOC
    sudoku.display_steps = true
    sudoku.solve
  end
end

