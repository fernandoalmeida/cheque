describe Cheque do
  subject(:cheque) { described_class.new(data, document) }

  let(:data) do
    {
      id: 1
    }
  end

  let(:document) { :copy }

  it { expect(cheque).to be_truthy }

  describe '#render' do
    subject(:render) { cheque.render }

    it { expect(render).to be_truthy }

    it do
      expect_any_instance_of(Cheque::Copy).to receive(:data)
      render
    end
  end
end
