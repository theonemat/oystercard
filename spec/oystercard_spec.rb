# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  let(:station){ double :station }

  it 'checks money on card' do
    expect(subject.balance).to eq 0
  end
  it 'lets me add money' do
    subject.top_up(10)
    expect(subject.balance).to eq 10
  end
  it 'raises an error if balance raised to more then 90' do
    subject.top_up(90)
    expect { subject.top_up(1) }.to raise_error "Limit is #{Oystercard::LIMIT}"
  end
  it 'deducts money' do
    subject.deduct(10)
    expect(subject.balance).to eq -10
  end
  it 'allows me to touch in' do
    subject.top_up(10)
    subject.touch_in(station)
    expect(subject).to be_in_journey
  end
  it 'allows me to touch out' do
    subject.top_up(10)
    subject.touch_in(station)
    subject.touch_out
    expect(subject).not_to be_in_journey
  end
  it 'raises an error if i touch in with balance less than 1' do
    subject.top_up(0.99)
    expect { subject.touch_in(station) }.to raise_error 'Insufficient balance'
  end
  it 'deducts minimum fare on touch out' do
    subject.top_up(10)
    subject.touch_in(station)
    expect { subject.touch_out }.to change { subject.balance }.by(-Oystercard::MINIMUM)
  end
  it 'remembers station at touch_in' do
    subject.top_up(10)
    subject.touch_in(station)
    expect(subject.entry_station).to eq station
  end
  it 'removes entery station' do
  subject.top_up(10)
  subject.touch_in(station)
  subject.touch_out
  expect(subject.entry_station).to eq nil
  end
end
