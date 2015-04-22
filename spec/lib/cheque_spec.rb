describe Cheque do
  subject(:cheque) { described_class.new(data, document) }

  let(:data) do
    {
      id: 1,
      title: 'Payment',
      bank: 'Global Banking',
      agency_number: '123',
      account_number: '456',
      cheque_number: '789',
      account_holder: 'Jimmy Hendrix Group',
      nominal_to: 'Fernando Almeida',
      amount: '100.00',
      location: 'Sao Paulo',
      date: Date.new(2015, 4, 7)
    }
  end

  let(:document) { :copy }

  let(:formater) { Cheque::Copy }

  it { expect(cheque).to be_truthy }

  describe '#render' do
    subject(:render) { cheque.render }

    it { expect(render).to be_truthy }

    it 'delegates to formater' do
      expect_any_instance_of(formater).to receive(:data)

      render
    end
  end

  describe '#filename' do
    subject(:filename) { cheque.filename }

    it 'delegates to formater' do
      expect_any_instance_of(formater).to receive(:filename)

      filename
    end
  end
end
