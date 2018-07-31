RSpec.describe Sudoku::SolveStep::UsingOpenSingle do
  let(:io) { StringIO.new }
  let(:sudoku) do
    Sudoku::Game::FourByFour.from_heredoc(
      <<~DOC
        1.|..
        2.|14
        --+--
        31|.2
        ..|.1
     DOC
    )
  end

  describe "#next_step" do
    subject { described_class.new(sudoku) }
    specify 'detemines cell and value, but does not apply' do
      expect(subject.next_step).to be_truthy
      expect(subject.cell.denied_values).to match_array [1,2,4]
      expect(subject.value).to eq 3

      sudoku.report(io)
      expect(io.string).to eq <<~DOC
        1.|..
        2.|14
        --+--
        31|.2
        ..|.1
      DOC

      subject.apply
      io.rewind
      sudoku.report(io)

      expect(io.string).to eq <<~DOC
        1.|.3
        2.|14
        --+--
        31|.2
        ..|.1
      DOC
    end
  end
end
