RSpec.describe Sudoku::Game::SixBySixHorizontal do
  describe '#report' do
    specify 'all values filled' do
      subject = described_class.from_matrix(
        [
          [1,2,3,4,5,6],
          [2,3,4,5,6,1],
          [3,4,5,6,1,2],
          [4,5,6,1,2,3],
          [5,6,1,2,3,4],
          [6,1,2,3,4,nil],
        ]
      )

      expect(subject.to_s).to eq <<~DOC
        123|456
        234|561
        ---+---
        345|612
        456|123
        ---+---
        561|234
        612|34.
      DOC
    end
  end

  describe "#solve" do
    subject do
      described_class.from_heredoc <<~DOC
        ..6|..2
        .2.|15.
        ---+---
        3..|...
        ...|..3
        ---+---
        .64|.1.
        1..|6..
      DOC
    end
    it 'solves all cells' do
      subject.solve
      expect(subject.to_s).to eq <<~DOC
        516|432
        423|156
        ---+---
        342|561
        651|243
        ---+---
        264|315
        135|624
      DOC
    end
  end
end
