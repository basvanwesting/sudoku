RSpec.describe Sudoku::Game::SixBySixVertical do
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
        12|34|56
        23|45|61
        34|56|12
        --+--+--
        45|61|23
        56|12|34
        61|23|4.
      DOC
    end
  end

  describe "#solve" do
    subject do
      described_class.from_heredoc <<~DOC
        ..6..2
        .2.15.
        3.....
        .....3
        .64.1.
        1..6..
      DOC
    end
    it 'solves all cells, until no solution is left' do
      subject.solve
      expect(subject.to_s).to eq <<~DOC
        51|64|32
        42|31|56
        3.|25|41
        --+--+--
        .4|12|63
        26|43|15
        13|56|24
      DOC
    end
  end
end
