# frozen_string_literal: true

require 'oystercard'

describe Oystercard do
  let(:entry_station){ double :entry_station }
  let(:exit_station){ double :exit_station }

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
    subject.touch_in(entry_station)
    expect(subject).to be_in_journey
  end
  it 'allows me to touch out' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject).not_to be_in_journey
  end
  it "raises an error if i touch in with balance less than #{:MINIMUM}" do
    subject.top_up(0.99)
    expect { subject.touch_in(entry_station) }.to raise_error 'Insufficient balance'
  end
  it 'deducts minimum fare on touch out' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM)
  end
  it 'remembers station at touch_in' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    expect(subject.entry_station).to eq entry_station
  end
  it 'removes entery station' do
  subject.top_up(10)
  subject.touch_in(entry_station)
  subject.touch_out(exit_station)
  expect(subject.entry_station).to eq nil
  end
  it 'puts exist_Station' do
  subject.top_up(10)
  subject.touch_in(entry_station)
  subject.touch_out(exit_station)
  expect(subject.exit_station).to eq exit_station
  end

  let(:journey) {{entry_station: entry_station , exit_station: exit_station }}
  it 'puts stations into array' do
  subject.top_up(10)
  subject.touch_in(entry_station)
  subject.touch_out(exit_station)
  expect(subject.journey_list).to include journey
  end

end
