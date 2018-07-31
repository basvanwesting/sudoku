RSpec.describe Sudoku::Game::TwoByTwo do
  let(:io) { StringIO.new }
  describe '#report' do
    specify 'all values filled' do
      subject = described_class.from_matrix(
        [
          [1,2],
          [3,nil],
        ]
      )
      subject.report(io)

      expect(io.string).to eq <<~DOC
        1|2
        -+-
        3|.
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

      expect(io.string).to eq <<~DOC
        .|.
        -+-
        .|.
      DOC
    end
    specify 'start normal' do
      subject = described_class.from_matrix(
        [
          [1,nil],
          [nil,nil],
        ]
      )
      subject.report(io)

      expect(io.string).to eq <<~DOC
        1|.
        -+-
        .|.
      DOC
    end
  end

  describe "#next_cell_for_solve_by_deny" do
    specify 'first step' do
      subject = described_class.from_matrix(
        [
          [1,nil],
          [nil,nil],
        ]
      )
      subject.update_cells
      cell, value = subject.next_cell_for_solve_by_deny
      expect(cell.value).to eq nil
      expect(cell.denied_values).to match_array [1]
    end
  end

  describe ".from_matrix and from_heredoc" do
    it 'is all the same result' do
      sudoku_from_matrix = described_class.from_matrix(
        [
          [1,nil],
          [nil,nil],
        ]
      )
      sudoku_from_heredoc = described_class.from_heredoc(
        <<~DOC
          1|.
          -+-
          .|.
        DOC
      )
      sudoku_from_sparse_heredoc = described_class.from_heredoc(
        <<~DOC
          1.
          ..
        DOC
      )

      expect(sudoku_from_matrix.cells.map(&:value)).to         eq [1,nil,nil,nil]
      expect(sudoku_from_heredoc.cells.map(&:value)).to        eq [1,nil,nil,nil]
      expect(sudoku_from_sparse_heredoc.cells.map(&:value)).to eq [1,nil,nil,nil]
    end
  end

  describe "#solve" do
    specify 'solve all' do
      subject = described_class.from_heredoc(
        <<~DOC
          1|.
          -+-
          .|.
        DOC
      )
      subject.solve
      subject.report(io)

      expect(io.string).to eq <<~DOC
        1|2
        -+-
        2|1
      DOC
    end
  end
end
