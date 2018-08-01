RSpec.describe Sudoku::SolveStep::UsingHiddenSingle do
  let(:sudoku) do
    Sudoku::Game::NineByNine.from_heredoc <<~DOC
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

  describe "#next_step" do
    subject { described_class.new(sudoku) }
    it 'detemines cell & value, and applies' do
      expect(Sudoku::SolveStep::UsingOpenSingle.new(sudoku).next_step).to be_falsy

      expect(subject.call).to be_truthy
      expect(subject.cell.coordinates).to eq [3,3]
      expect(subject.value).to eq 4

      expect(sudoku.to_s).to eq <<~DOC
        ...|..1|8.5
        8..|..4|.96
        ..6|...|..1
        ---+---+---
        ..8|4..|..3
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
