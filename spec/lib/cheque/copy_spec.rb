describe Cheque::Copy do
  subject(:copy) { described_class.new(params) }

  let(:params) do
    {
      id: 1
    }
  end

  it { is_expected.to be_truthy }
  it { expect(copy.id).to eq(1) }

  describe '#data' do
    let(:strings) { PDF::Inspector::Text.analyze(copy.data).strings.join }
    let(:pages) { PDF::Inspector::Page.analyze(copy.data).pages }

    it { expect(copy.data).to be_truthy }
    it { expect(pages.size).to eq(1) }
    it { expect(strings).to include('Cheque Copy Number: 1') }
  end

  describe '#file' do
    subject(:file) { copy.file }

    it { expect(file).to be_truthy }
    it { expect(file).to match(/(pdf)$/) }
    it { expect(File.exist?(file)).to be_truthy }

    after { File.unlink(file) if File.exist?(file) }
  end
end
