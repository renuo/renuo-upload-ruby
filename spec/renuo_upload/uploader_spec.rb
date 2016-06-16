require 'spec_helper'

RSpec.describe RenuoUpload do
  let(:file) { load_file('file.txt') }

  def load_file(name)
    File.new(File.expand_path("../../data/#{name}", __FILE__))
  end

  describe '#upload' do
    let(:fake_uploader) { Struct.new(:upload).new }
    let(:file_url) { 'https://file.url' }

    it 'can upload a file' do
      expect(RenuoUpload::Uploader).to receive(:new).with(RenuoUpload.config).and_return(fake_uploader)
      expect(fake_uploader).to receive(:upload).with(file).and_return(file_url)
      expect(described_class.upload!(file)).to eq file_url
    end
  end

  describe RenuoUpload::Uploader do
    let(:uploader) { described_class.new(config) }
    let(:config) { RenuoUpload.config }
    let(:policy) { JSON.parse(load_file('policy.json').read) }

    before do
      config.api_key = 'api-key'
      config.signing_url = 'signing-url'
      stub_request(:post, config.signing_url).to_return(body: load_file('policy.json'))
    end

    describe '#new' do
      it 'can be initialized with the renuo upload config' do
        expect(uploader.instance_variable_get(:@policy)).to eq policy
        expect(uploader.instance_variable_get(:@config)).to be RenuoUpload.config
      end
    end

    describe '#upload' do
      let(:file_url) { '//cdn.renuoapp.ch/o/application/1xyj/db9f/aac4/3a98/2d85/e016/aa7d/700f/7ed0/file.txt' }

      it 'upload the file to the provided server by the policy' do
        stub = stub_request(:post, policy['url']).with(headers: { 'Content-Length' => '1512' })

        expect(uploader.upload(file)).to eq file_url

        expect(stub).to have_been_requested
      end
    end

    describe '#retrieve_policy' do
      it 'requests the policy from the renuo upload service' do
        expect(uploader.send(:retrieve_policy).values_at('url', 'data')).to_not include(nil)
      end
    end

    describe '#upload_hash' do
      it 'removes underscores and replace them with dashes, just for the keys' do
        expect(uploader).to receive(:upload_data).and_return('key_key_key' => 'value')
        uploaded_hash = uploader.send(:upload_hash, 'dummy_file')
        expect(uploaded_hash['key-key-key']).to eq 'value'
        expect(uploaded_hash[:file]).to eq 'dummy_file'
      end
    end
  end
end
