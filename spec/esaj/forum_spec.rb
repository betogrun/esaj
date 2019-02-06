require 'spec_helper'

RSpec.describe Esaj::Forum do
  describe '.code_for' do
    it do
      expect(Esaj::Forum.code_for(:all)).to eq("-1")
    end
  end
end
