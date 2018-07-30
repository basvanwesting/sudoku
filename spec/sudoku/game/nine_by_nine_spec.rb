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
          [9,1,2,3,4,5,6,7,nil],
        ]
      )
      subject.report(io)

      expect(io.string).to eq <<~DOC
        123|456|789
        234|567|891
        345|678|912
        ---+---+---
        456|789|123
        567|891|234
        678|912|345
        ---+---+---
        789|123|456
        891|234|567
        912|345|67.
      DOC
    end
  end

  describe "#simple_solve" do
    specify 'simple_solve all' do
      subject = described_class.from_heredoc(
        <<~DOC
          ...|..1|8.5
          8..|..4|.96
          ..6|...|..1
          ---+---+---
          ..8|...|...
          .43|.8.|9..
          5..|.93|...
          ---+---+---
          7..|3..|218
          ...|71.|...
          .5.|.4.|..7
        DOC
      )
      subject.simple_solve
      subject.report(io)

      expect(io.string).to eq <<~DOC
        ...|..1|8.5
        8..|..4|.96
        ..6|...|..1
        ---+---+---
        ..8|...|..3
        .43|.8.|9.2
        5..|.93|..4
        ---+---+---
        7..|3..|218
        ...|71.|..9
        .5.|.4.|..7
      DOC
    end
  end
end
