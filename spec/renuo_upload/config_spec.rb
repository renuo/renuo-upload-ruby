require 'spec_helper'

RSpec.describe RenuoUpload do
  let(:config) { config = RenuoUpload::Config.new }

  describe RenuoUpload::Config do
    [
      [:RENUO_UPLOAD_API_KEY, :api_key, 'custom-api-key', 'new-key'],
      [:RENUO_UPLOAD_SIGNING_URL, :signing_url, 'custom-signing-url', 'new-su']
    ].each do |env_variable_name, method, default_value, new_value|
      describe "##{method}" do
        it 'is the default value from the ENV variable' do
          ClimateControl.modify env_variable_name => default_value do
            expect(config.send(method)).to eq(default_value)
          end
        end
      end

      describe "##{method}=" do
        it 'can set value without an env variable' do
          config.send("#{method}=", new_value)
          expect(config.send(method)).to eq(new_value)
        end

        it 'can set value when an env variable is defined' do
          ClimateControl.modify env_variable_name => default_value do
            config.send("#{method}=", new_value)
            expect(config.send(method)).to eq(new_value)
          end
        end
      end

      describe "#reset (#{method})" do
        it "resets the #{method}" do
          ClimateControl.modify env_variable_name => default_value do
            RenuoUpload.configure { |config| config.send("#{method}=", new_value) }
            expect { RenuoUpload.reset }.to change{ RenuoUpload.config.send(method) }.from(new_value).to(default_value)
          end
        end
      end
    end
  end
end
