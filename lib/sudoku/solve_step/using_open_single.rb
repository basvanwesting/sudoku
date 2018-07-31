class Sudoku::SolveStep::UsingOpenSingle < Sudoku::SolveStep
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
    existing_values = container.cells.map { |cell| cell.value }.compact
    container.cells.each do |cell|
      cell.add_denied_values(existing_values)
    end
  end
end
