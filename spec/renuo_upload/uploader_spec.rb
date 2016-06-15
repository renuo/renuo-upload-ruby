require 'spec_helper'

RSpec.describe RenuoUpload do
  describe '#upload!' do
    let(:fake_uploader) { Struct.new(:upload!).new }
    let(:file) { File.new(File.expand_path('../../data/file.txt', __FILE__)) }
    let(:file_url) { 'https://file.url' }

    it 'can upload a file' do
      expect(RenuoUpload::Uploader).to receive(:new).with(RenuoUpload.config).and_return(fake_uploader)
      expect(fake_uploader).to receive(:upload!).with(file).and_return(file_url)
      expect(described_class.upload!(file)).to eq file_url
    end
  end

  describe RenuoUpload::Uploader do
    describe '#new' do
      it 'can be initialized with the renuo upload config' do
        expect(described_class.new(RenuoUpload.config).instance_variable_get(:@config)).to be RenuoUpload.config
      end
    end
  end
end
