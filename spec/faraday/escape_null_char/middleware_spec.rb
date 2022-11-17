# frozen_string_literal: true

RSpec.describe Faraday::EscapeNullChar::Middleware do
  describe '.escape_str' do
    subject(:klass) { described_class }

    it 'escapes null char' do
      expect(klass.escape_str(+'\u0000')).to eq('\\\\u0000')
    end

    it 'does not escape escaped null char' do
      expect(klass.escape_str(+'\\\\u0000')).to eq('\\\\u0000')
    end

    it 'escape null char with slash in front' do
      expect(klass.escape_str(+'\\\\\\u0000')).to eq('\\\\\\\\u0000')
    end
  end
end
