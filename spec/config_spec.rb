RSpec.describe Dual::Configuration do
  subject { described_class.new(Object.new) }

  describe '#excludes' do
    it 'adds properties to be excluded' do
      subject.excludes(:name, :type)

      expect(subject.excluded).to eq([:name, :type])
    end
  end

  describe '#includes' do
    it 'adds properties to be included' do
      subject.includes(:name, :type)

      expect(subject.included).to eq([:name, :type])
    end
  end
end
