require 'amount'


describe Amount do

  # Todo, test parsing and formatting of negative numbers...

  it 'represents 6.15 bitcoin' do

    amount = Amount BTC: 6.15

    expect(amount.eps).to eq 6150000000000000000
    expect(amount.inspect).to eq "6.150000000000000000 BTC"
    expect(amount.format).to eq "6.15000000 BTC"
    expect(amount.to_s).to eq "6.15000000 BTC"
  end

  describe 'when formatting' do

    it { expect((eth 100).inspect).to eq "100.000000000000000000 ETH"}
    it { expect((eth 0.25).inspect).to eq "0.250000000000000000 ETH"}
    it { expect((eth 0.01).inspect).to eq "0.010000000000000000 ETH"}
    it { expect((eth 0).inspect).to eq "0.000000000000000000 ETH"}
    it { expect(Amount.from_fractions(:ETH, 1).inspect).to eq "0.000000000000000001 ETH"}
  end

  describe 'when parsing' do

    it { expect(Amount.parse '100 ETH').to eq(eth 100)}
    it { expect(Amount.parse '0.25 ETH').to eq(eth 0.25)}
    it { expect(Amount.parse '0.01 ETH').to eq(eth 0.01)}
    it { expect(Amount.parse '0 ETH').to eq(eth 0)}
  end

  describe "when doing arithmetic operations" do

    let(:a) { Amount BTC: 3.5}
    let(:b) { Amount BTC: 2.65 }

    it { expect((a + b).inspect).to eq '6.150000000000000000 BTC'}
    it { expect((a - b).inspect).to eq '0.850000000000000000 BTC'}
    it { expect((a * b).inspect).to eq '9.275000000000000000 BTC'}
    it { expect((a / b).inspect).to eq '1.320754716981132075 BTC'}

    let(:dogecoin) { Amount doge: 1 }

    it { expect{ a + dogecoin }.to raise_error RuntimeError }
    it { expect{ a - dogecoin }.to raise_error RuntimeError }
    it { expect{ a * dogecoin }.to raise_error RuntimeError }
    it { expect{ a / dogecoin }.to raise_error RuntimeError }
  end

  describe 'when using amounts for number arithmetics' do
    it { expect((Fixed 300) / (eth 2)).to eq (Fixed 150) }
    it { expect((eth 3) * (Fixed 0.5)).to eq (eth 1.5) }
  end
end
