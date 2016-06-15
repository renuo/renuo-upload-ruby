module RenuoUpload
  def self.upload!(file)
    Uploader.new(RenuoUpload.config).upload!(file)
  end

  class Uploader
    def initialize(config)
      @config = config
    end
  end
end
