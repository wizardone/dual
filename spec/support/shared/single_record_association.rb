RSpec.shared_examples :single_record_association do
  subject { described_class }
  let(:association) { 'association' }
  let(:original_object) do
    Class.new { attr_accessor :association }.new
  end
  let(:reflection) { Hash[:name, association] }
  let(:dual_object) { original_object.dup }
  let(:base) { subject.new(original_object, dual_object, reflection) }

  describe '#copy' do
    it 'copies the association to the dupped object' do
      expect(original_object).to receive(:association)
      expect(dual_object).to receive("#{association}=").twice

      base.copy
    end
  end

  describe '#remove' do
    it 'removes the association from the dupped object' do
      expect(dual_object).to receive("#{association}=").with(nil)

      base.remove
    end
  end
end
