RSpec.describe Sudoku::SolveStep::UsingOpenDouble do
  let(:sudoku) do
    Sudoku::Game::NineByNine.from_heredoc(
      <<~DOC
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
    )
  end

  describe "#next_step" do
    subject { described_class.new(sudoku) }
    specify 'detemines cell & value, and applies' do
      expect(Sudoku::SolveStep::UsingOpenSingle.new(sudoku).next_step).to be_falsy
      expect(Sudoku::SolveStep::UsingHiddenSingle.new(sudoku).next_step).to be_falsy

      expect(subject.call).to be_truthy
      expect(subject.cell.denied_values).to match_array [1, 2, 3, 4, 5, 6, 7, 8]
      expect(subject.value).to eq 9

      expect(sudoku.to_s).to eq <<~DOC
         1..|249|678
         786|351|...
         .4.|876|153
         ---+---+---
         ..1|493|.8.
         498|627|.1.
         ...|185|4..
         ---+---+---
         ..7|.18|...
         ..4|762|891
         81.|.34|7..
      DOC
    end
  end
end
