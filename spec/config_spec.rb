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
      subject.includes(:name, value: 'Stefan')

      expect(subject.included).to match_array([{property: :name, value: 'Stefan'}])
    end
  end

  describe '#add_association' do
    it 'adds associations to be included' do
      subject.add_association(:address1, :address2)

      expect(subject.associations).to eq([:address1, :address2])
    end
  end
end
