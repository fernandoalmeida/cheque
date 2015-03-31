describe Cheque::Copy do
  subject(:copy) { described_class.new(params) }

  let(:params) do
    {
      id: 1
    }
  end

  it { is_expected.to be_truthy }

  describe '#data' do
    let(:strings) { PDF::Inspector::Text.analyze(copy.data).strings.join }
    let(:pages) { PDF::Inspector::Page.analyze(copy.data).pages }

    it { expect(copy.data).to be_truthy }
    it { expect(pages.size).to eq(1) }
    it { expect(strings).to include("Cheque Copy Number: 1") }
  end
end
