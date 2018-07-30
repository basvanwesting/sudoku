RSpec.describe Sudoku::Game::NineByNine do
  let(:io) { StringIO.new }
  describe '#report' do
    specify 'all values filled' do
      subject = described_class.from_matrix(
        [
          [1,2,3,4,5,6,7,8,9],
          [2,3,4,5,6,7,8,9,1],
          [3,4,5,6,7,8,9,1,2],
          [4,5,6,7,8,9,1,2,3],
          [5,6,7,8,9,1,2,3,4],
          [6,7,8,9,1,2,3,4,5],
          [7,8,9,1,2,3,4,5,6],
          [8,9,1,2,3,4,5,6,7],
          [9,1,2,3,4,5,6,7,8],
        ]
      )
      subject.report(io)

      expect(io.string).to eq <<~DOC
        123|456|789
        234|567|891
        345|678|912
        -----------
        456|789|123
        567|891|234
        678|912|345
        -----------
        789|123|456
        891|234|567
        912|345|678
      DOC
    end
  end

  describe "#simple_solve" do
    specify 'simple_solve all' do
      subject = described_class.from_matrix(
        [
          [nil, nil, nil, nil, nil, 1,   8,   nil, 5],
          [8,   nil, nil, nil, nil, 4,   nil, 9,   6],
          [nil, nil, 6,   nil, nil, nil, nil, nil, 1],
          [nil, nil, 8,   nil, nil, nil, nil, nil, nil],
          [nil, 4,   3,   nil, 8,   nil, 9,   nil, nil],
          [5,   nil, nil, nil, 9,   3,   nil, nil, nil],
          [7,   nil, nil, 3,   nil, nil, 2,   1,   8],
          [nil, nil, nil, 7,   1,   nil, nil, nil, nil],
          [nil, 5,   nil, nil, 4,   nil, nil, nil, 7],
        ]
      )
      subject.simple_solve
      subject.report(io)

      expect(io.string).to eq <<~DOC
        14|23
        23|14
        -----
        31|42
        42|31
      DOC
    end
  end
end
