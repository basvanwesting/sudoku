RSpec.describe Sudoku::Game::FourByFour do
  let(:io) { StringIO.new }
  describe '#report' do
    specify 'all values filled' do
      subject = described_class.from_matrix(
        [
          [1,2,3,4],
          [5,6,7,8],
          [8,7,6,5],
          [4,3,2,nil],
        ]
      )
      subject.report(io)

      expect(io.string).to eq <<~DOC
        12|34
        56|78
        --+--
        87|65
        43|2.
      DOC
    end
  end

  describe "#solve" do
    specify 'solve all' do
      subject = described_class.from_heredoc(
        <<~DOC
          1.|..
          2.|14
          --+--
          31|.2
          ..|.1
       DOC
      )
      subject.solve
      subject.report(io)

      expect(io.string).to eq <<~DOC
        14|23
        23|14
        --+--
        31|42
        42|31
      DOC
    end
  end
end
