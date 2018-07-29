RSpec.describe Sudoku::Cell do

  subject { described_class.new(nil, value_range: 0..9) }

  specify '#deny_value' do
    subject.deny_value(1)
    subject.deny_value(3)
    subject.deny_value(5)
    subject.deny_value(3)
    subject.deny_value(1)
    expect(subject.denied_values).to match_array [1,3,5]
  end

  specify '#add_denied_values' do
    subject.deny_value(1)
    subject.deny_value(3)
    subject.deny_value(5)
    subject.add_denied_values([3,4,5,7])
    expect(subject.denied_values).to match_array [1,3,4, 5,7]
  end
end
