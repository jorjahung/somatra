require 'soma'

describe Soma do
  let(:base_uri) { 'http://somewhere.com' }
  let(:soma)     { Soma.new base_uri }

  it 'shows the legend' do
    expect(HTTParty).to receive(:get).with("#{base_uri}/legend")
    soma.legend
  end

  it 'shows all the tests' do
    expect(HTTParty).to receive(:get).with("#{base_uri}.json")
    soma.show_all
  end

  it 'shows a single test' do
    expect(HTTParty).to receive(:get).with("#{base_uri}/1.json")
    soma.show(1)
  end

  it 'shows all the Hb tests' do
    expect(HTTParty).to receive(:get).with("#{base_uri}/results/hb")
    soma.show_results_for("hb")
  end

  it 'posts results to API' do
    expect(HTTParty).to receive(:post).with("#{base_uri}/remote", body:1)
    soma.send_blood_test_result(1)
  end
end