class Sudoku::SolveStep::UsingOpenDouble < Sudoku::SolveStep
  def next_step
    update_cells
    unsolved_cells.each do |cell|
      if cell.allowed_values.size == 1
        self.cell  = cell
        self.value = cell.allowed_values.first
        return true
      end
    end
    return false
  end

  def update_cells
    containers.each { |c| update_cells_for_container(c) }
  end

  def update_cells_for_container(container)
    cells_with_two_allowed_values = container.unsolved_cells.select do |cell|
      cell.allowed_values.size == 2
    end
    pairs = cells_with_two_allowed_values.group_by(&:allowed_values).select do |allowed_values, cells|
      cells.size == 2
    end
    pairs.each do |allowed_values, cells|
      other_cells = container.cells - cells
      other_cells.each do |other_cell|
        other_cell.deny_values(allowed_values)
      end
    end
  end
end
