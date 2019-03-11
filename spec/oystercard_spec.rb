require 'oystercard'

describe Oystercard do
  it 'checks money on card' do
    expect(subject.balance).to eq 0
  end
  # it 'lets me add money' do
  #   subject.add(10)
  #   expect(subject.balance).to eq 10
  # end
end
