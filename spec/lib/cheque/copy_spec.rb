describe Cheque::Copy do
  subject(:copy) { described_class.new(params) }

  let(:params) do
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

  it { is_expected.to be_truthy }

  it { expect(copy.id).to eq(1) }

  describe '#data' do
    let(:strings) { PDF::Inspector::Text.analyze(copy.data).strings.join }
    let(:pages) { PDF::Inspector::Page.analyze(copy.data).pages }

    it { expect(copy.data).to be_truthy }
    it { expect(pages.size).to eq(1) }
    it { expect(strings).to include('Cheque copy number: 1') }
    it { expect(strings).to include('Bank: Global Banking') }
    it { expect(strings).to include('Agency: 123') }
    it { expect(strings).to include('Account: 456') }
    it { expect(strings).to include('Cheque number: 789') }
    it { expect(strings).to include('Account holder: Jimmy Hendrix Group') }
    it { expect(strings).to include('Nominal to: Fernando Almeida') }
    it { expect(strings).to include('Amount: $ 100.00') }
    it { expect(strings).to include('Sao Paulo, April 07, 2015') }
    xit { expect(strings).to include('Authorized signature') }
    xit { expect(strings).to include('Payer signature') }
  end

  describe '#file' do
    subject(:file) { copy.file }

    it { expect(file).to be_truthy }
    it { expect(file).to match(/(pdf)$/) }
    it { expect(File.exist?(file)).to be_truthy }

    after { File.unlink(file) if File.exist?(file) }
  end
end
