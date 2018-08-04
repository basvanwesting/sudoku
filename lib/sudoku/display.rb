class Sudoku::Display
  attr_accessor :sudoku

  DEFAULT_REDRAW_DELAY = 0.3

  def initialize(sudoku)
    self.sudoku = sudoku
  end

  def to_s
    io = StringIO.new
    display_on_io(io)
    io.string
  end

  def redraw(delay: DEFAULT_REDRAW_DELAY)
    system 'clear'
    puts to_s
    sleep delay
  end

  def display_on_io(io)
    areas_per_line = sudoku.class::VALUE_RANGE.size / sudoku.class::AREA_WIDTH
    line_width = sudoku.class::VALUE_RANGE.size + areas_per_line - 1
    sudoku.rows.each_slice(sudoku.class::AREA_HEIGHT) do |sub_rows|
      sub_rows.each do |cells|
        cells.each_slice(sudoku.class::AREA_WIDTH) do |sub_cells|
          io.write sub_cells.map { |c| c.value || '.' }.join('')
          io.write '|'
        end
        io.seek(io.pos - 1) && io.truncate(io.pos)
        io.puts
      end
      areas_per_line.times do
        io.write '-' * sudoku.class::AREA_WIDTH
        io.write '+'
      end
      io.seek(io.pos - 1) && io.truncate(io.pos)
      io.puts
    end
    io.seek(io.pos - line_width - 1) && io.truncate(io.pos)
    io
  end

end
