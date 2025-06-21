require 'rails_helper'

RSpec.describe PayrollCalculatorHelper, type: :helper do
  describe '#format_currency' do
    it 'formatea números con separadores de miles' do
      expect(helper.number_with_delimiter(1000000)).to eq('1,000,000')
    end
  end
end