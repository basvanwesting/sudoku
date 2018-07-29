RSpec.describe Sudoku::Game::TwoByTwo do
  let(:io) { StringIO.new }
  specify '.from_matrix' do
    subject = described_class.from_matrix(
      [
        [1,2],
        [3,4],
      ]
    )
    subject.report(io)

    expect(io.string).to eq <<~DOC
      1|2
      ---
      3|4
    DOC
  end
end
