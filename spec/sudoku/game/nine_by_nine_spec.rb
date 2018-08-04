RSpec.describe Sudoku::Game::NineByNine do
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

      expect(subject.to_s).to eq <<~DOC
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
    context '2 star' do
      subject do
        described_class.from_heredoc <<~DOC
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
      end
      it 'solves all cells' do
        subject.solve
        expect(subject.to_s).to eq <<~DOC
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
    end
    context '3 star' do
      subject do
        described_class.from_heredoc <<~DOC
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
      end
      it 'solves all cells' do
        subject.solve
        expect(subject.to_s).to eq <<~DOC
          135|249|678
          786|351|942
          942|876|153
          ---+---+---
          561|493|287
          498|627|315
          273|185|469
          ---+---+---
          627|918|534
          354|762|891
          819|534|726
        DOC
      end
    end
    context '4 star' do
      subject do
        described_class.from_heredoc <<~DOC
          ...|.3.|2..
          ..9|.4.|...
          31.|2..|...
          ---+---+---
          ...|3..|.5.
          .5.|1..|..6
          ...|...|.91
          ---+---+---
          4..|...|6..
          ..5|.84|...
          926|..7|..4
        DOC
      end
      it 'solves all cells' do
        subject.solve
        expect(subject.to_s).to eq <<~DOC
          547|831|269
          269|745|183
          318|296|547
          ---+---+---
          194|362|758
          853|179|426
          672|458|391
          ---+---+---
          481|923|675
          735|684|912
          926|517|834
        DOC
      end
    end
  end
end
