module RenuoUpload
  def self.upload!(file)
    Uploader.new(RenuoUpload.config).upload(file)
  end

  class Uploader
    def initialize(config)
      @config = config
      @policy = retrieve_policy
    end

    def upload(file)
      RestClient.post upload_url, upload_hash(file)
      uploaded_file_url file
    end

    private

    def retrieve_policy
      response = RestClient.post @config.signing_url, api_key: @config.api_key
      JSON.parse response.body
    end

    def upload_url
      @policy['url']
    end

    def upload_data
      @policy['data']
    end

    def upload_hash(file)
      Hash[upload_data.map { |key, value| [key.tr('_', '-'), value] }].merge file: file
    end

    def uploaded_file_url(file)
      @policy['file_url_path'].concat File.basename(file)
    end
  end
end
