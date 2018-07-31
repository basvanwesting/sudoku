#no update cells needed, rely on UsingOpenSingle as precondition
class Sudoku::SolveStep::UsingHiddenSingle < Sudoku::SolveStep
  def next_step
    containers.each do |container|
      hash = Hash.new { |h,k| h[k] = [] }
      container.cells.reject(&:value).each do |cell|
        cell.allowed_values.each do |allowed_value|
          hash[allowed_value] << cell
        end
      end
      hash.each do |value, cells|
        if cells.size == 1
          self.cell  = cells.first
          self.value = value
          return true
        end
      end
    end
    return false
  end
end
