RSpec.describe Sudoku::Game::TwoByTwo do
  let(:io) { StringIO.new }
  describe '#report' do
    specify 'all values filled' do
      subject = described_class.from_matrix(
        [
          [1,2],
          [3,4],
        ]
      )
      subject.report(io)

      expect(io.string).to eq <<~DOC
        1|2
        ---
        3|4
      DOC
    end
    specify 'all values empty' do
      subject = described_class.from_matrix(
        [
          [nil,nil],
          [nil,nil],
        ]
      )
      subject.report(io)

      expect(io.string).to eq " | \n---\n | \n"
    end
    specify 'start normal' do
      subject = described_class.from_matrix(
        [
          [1,nil],
          [nil,nil],
        ]
      )
      subject.report(io)

      expect(io.string).to eq "1| \n---\n | \n"
    end
  end

  describe "#next_cell" do
    specify 'first step' do
      subject = described_class.from_matrix(
        [
          [1,nil],
          [nil,nil],
        ]
      )
      subject.update_cells
      cell = subject.next_cell
      expect(cell.value).to eq nil
      expect(cell.denied_values).to match_array [1]
    end
  end

  describe "#simple_solve" do
    specify 'simple_solve all' do
      subject = described_class.from_matrix(
        [
          [1,nil],
          [nil,nil],
        ]
      )
      subject.simple_solve
      subject.report(io)

      expect(io.string).to eq <<~DOC
        1|2
        ---
        2|1
      DOC
    end
  end
end
