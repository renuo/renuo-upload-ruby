module RenuoUpload
  def self.upload!(file)
    Uploader.new(RenuoUpload.config).upload!(file)
  end

  class Uploader
    def initialize(config)
      @config = config
      @policy = retrieve_policy
    end

    private

    def retrieve_policy
      response = RestClient.post @config.signing_url, api_key: @config.api_key
      JSON.parse response.body
    end
  end
end
