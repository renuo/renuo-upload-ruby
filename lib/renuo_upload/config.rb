module RenuoUpload
  class << self
    attr_writer :config
  end

  def self.config
    @config ||= Config.new
  end

  def self.reset
    @config = Config.new
  end

  def self.configure
    yield(config)
  end

  class Config
    attr_accessor :api_key, :signing_url

    def initialize
      self.api_key = ENV['RENUO_UPLOAD_API_KEY']
      self.signing_url = ENV['RENUO_UPLOAD_SIGNING_URL']
    end
  end
end
