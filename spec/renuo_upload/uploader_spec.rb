require 'spec_helper'

RSpec.describe RenuoUpload do
  let(:file) { load_file('file.txt') }

  def load_file(name)
    File.new(File.expand_path("../../data/#{name}", __FILE__))
  end

  describe '#upload!' do
    let(:fake_uploader) { Struct.new(:upload!).new }
    let(:file_url) { 'https://file.url' }

    it 'can upload a file' do
      expect(RenuoUpload::Uploader).to receive(:new).with(RenuoUpload.config).and_return(fake_uploader)
      expect(fake_uploader).to receive(:upload!).with(file).and_return(file_url)
      expect(described_class.upload!(file)).to eq file_url
    end
  end

  describe RenuoUpload::Uploader do
    let(:uploader) { described_class.new(config) }
    let(:config) do
      RenuoUpload.config.api_key = 'api-key'
      RenuoUpload.config.signing_url = 'signing-url'
      RenuoUpload.config
    end
    let(:policy) { load_file('policy.json') }

    describe '#new' do
      let(:dummy_policy) { :dummy_policy }

      it 'can be initialized with the renuo upload config' do
        expect_any_instance_of(described_class).to receive(:retrieve_policy).and_return(dummy_policy)
        expect(uploader.instance_variable_get(:@policy)).to be dummy_policy
        expect(uploader.instance_variable_get(:@config)).to be RenuoUpload.config
      end
    end

    describe '#retrieve_policy' do
      it 'requests the policy from the renuo upload service' do
        stub_request(:post, config.signing_url).to_return(body: policy)
        expect(uploader.send(:retrieve_policy).values_at('url', 'data')).to_not include(nil)
      end
    end
  end
end
