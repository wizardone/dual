require 'spec_helper'

RSpec.describe Dual::Associations::Base do
  subject { described_class }
  let(:original_object) { Object.new }
  let(:reflection) { Object.new }
  let(:dual_object) { original_object.dup }
  let(:base) { subject.new(original_object, dual_object, reflection) }

  describe '#initialize' do
    it 'initializes the base class' do
      base = subject.new(original_object, dual_object, reflection)

      expect(base.original_object).to eq(original_object)
      expect(base.dual_object).to eq(dual_object)
      expect(base.association_reflection).to eq(reflection)
    end
  end

  describe '#copy' do
    it 'raises a not implemented error' do
      expect { base.copy }.to raise_error(NotImplementedError)
    end
  end

  describe '#remove' do
    it 'raises a not implemented error' do
      expect { base.remove }.to raise_error(NotImplementedError)
    end
  end
end
