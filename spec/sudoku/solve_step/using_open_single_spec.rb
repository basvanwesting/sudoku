RSpec.describe Sudoku::SolveStep::UsingOpenSingle do

  describe "#call" do
    context 'success' do
      let(:sudoku) do
        Sudoku::Game::FourByFour.from_heredoc <<~DOC
          1.|..
          2.|14
          --+--
          31|.2
          ..|.1
       DOC
      end
      subject { described_class.new(sudoku) }
      specify 'detemines cell & value, and applies' do
        expect(subject.call).to be_truthy
        expect(subject.cell.denied_values).to match_array [1,2,4]
        expect(subject.value).to eq 3

        expect(sudoku.to_s).to eq <<~DOC
          1.|.3
          2.|14
          --+--
          31|.2
          ..|.1
        DOC
      end
    end
    context 'failure' do
      let(:sudoku) do
        Sudoku::Game::FourByFour.from_heredoc <<~DOC
          1.|..
          .2|..
          --+--
          ..|3.
          ..|.4
       DOC
      end
      subject { described_class.new(sudoku) }
      specify 'cannot detemines cell & value' do
        expect(subject.call).to be_falsey
        expect(subject.cell).to eq nil
        expect(subject.value).to eq nil

        expect(sudoku.to_s).to eq <<~DOC
          1.|..
          .2|..
          --+--
          ..|3.
          ..|.4
        DOC
      end
    end
  end
end
