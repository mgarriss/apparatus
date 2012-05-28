require 'spec_helper'

describe App::Output do
  it 'accepts the CC messages' do
    AppOut << ['cc',56,0]
    AppOut.received.should eq(['cc',56,0])
    AppOut.produced.should eq([176,0,56])
  end
end
