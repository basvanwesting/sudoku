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

  describe "#solve" do
    specify 'solve 2 star' do
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
      subject.solve
      subject.report(io)

      expect(io.string).to eq <<~DOC
        437|961|825
        815|274|396
        296|538|471
        ---+---+---
        978|425|163
        643|187|952
        521|693|784
        ---+---+---
        764|359|218
        382|716|549
        159|842|637
      DOC
    end

    specify 'solve 3 star' do
      subject = described_class.from_heredoc(
        <<~DOC
          1..|2..|678
          ...|.5.|...
          .4.|..6|.5.
          ---+---+---
          ..1|4.3|.8.
          ..8|.27|...
          ...|1..|4..
          ---+---+---
          ..7|.1.|...
          ...|.6.|891
          ...|..4|7..
        DOC
      )
      subject.solve
      subject.report(io)

      expect(io.string).to eq <<~DOC
        1..|249|678
        786|351|...
        .4.|876|153
        ---+---+---
        ..1|493|.8.
        4.8|627|.1.
        ...|185|4..
        ---+---+---
        ..7|.18|...
        ..4|762|891
        81.|.34|7..
      DOC
    end
  end
end
