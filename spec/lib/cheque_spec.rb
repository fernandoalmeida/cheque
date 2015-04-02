describe Cheque do
  subject(:cheque) { described_class.new(data, document) }

  let(:data) do
    {
      id: 1
    }
  end

  let(:document) { :copy }

  it { is_expected.to be_truthy }

  describe '#render' do
    subject(:render) { cheque.render }

    it { expect(render).to be_truthy }
  end
end
