RSpec.describe Sudoku::Game::FourByFour do
  let(:io) { StringIO.new }
  describe '#report' do
    specify 'all values filled' do
      subject = described_class.from_matrix(
        [
          [1,2,3,4],
          [5,6,7,8],
          [8,7,6,5],
          [4,3,2,1],
        ]
      )
      subject.report(io)

      expect(io.string).to eq <<~DOC
        12|34
        56|78
        --+--
        87|65
        43|21
      DOC
    end
  end

  describe "#simple_solve" do
    specify 'simple_solve all' do
      subject = described_class.from_matrix(
        [
          [1,   nil, nil, nil],
          [2,   nil, 1,   4],
          [3,   1,   nil, 2],
          [nil, nil, nil, 1],
        ]
      )
      subject.simple_solve
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
