require 'spec_helper'

module ClearSaleClearId
  describe Server do
    before do
      ENV['CS_SERVICE_URL'] = default_service_url
      ENV['CS_WSDL_URL'] = default_wsdl_url
    end

    let(:default_service_url) { ENV['CS_SERVICE_URL'] }
    let(:default_wsdl_url) { ENV['CS_WSDL_URL'] }
    let(:default_entity_code) { ENV['CS_ENTITY_CODE'] }
    let(:server) { described_class.new(savon_client: savon_client) }
    let(:savon_client) { nil }

    describe '#submit_info' do
      let(:order) { build(:order, :malicious, id: 45) }

      it 'returns a ClearSaleClearId::Response::PackageStatus' do
        VCR.use_cassette('submit_info', :record => :new_episodes) do
          expect(server.submit_info(order).class).to eq(Response::PackageStatus)
        end
      end

      describe '' do
        let(:savon_client) { double(:savon_client) }
        let(:clear_sale_response) do
          double(:response, body: submit_info_response)
        end
        let(:submit_info_response) do
          { submit_info_response: { submit_info_result: attributes}}
        end

        let(:package_status) { double(:package_status) }
        let(:attributes) { double(:attributes) }

        it 'returns the PackageStatus object with the package informations' do
          allow(savon_client).to receive(:call) { clear_sale_response }
          allow(Response::PackageStatus).to receive(:new).with(attributes) do
            package_status
          end

          expect(server.submit_info(order)).to eq(package_status)
        end
      end
    end

    describe '#service_url' do
      it 'uses CS_SERVICE_URL as default value' do
        ENV['CS_SERVICE_URL'] = default_service_url

        expect(server.service_url).to eq(default_service_url)
      end

      describe 'when the user pass the service_url' do
        let(:server) { described_class.new(service_url: service_url) }

        let(:service_url) { 'service_url' }

        it 'uses the service_url' do
          expect(server.service_url).to eq(service_url)
        end
      end

      describe 'when there is no ENV set' do
        it 'raises an argument error' do
          ENV.delete('CS_SERVICE_URL')
          expect { server.service_url }.to raise_error(KeyError)
        end
      end
    end

    describe '#entity_code' do
      it 'uses CS_ENTITY_CODE as default value' do
        ENV['CS_ENTITY_CODE'] = default_entity_code

        expect(server.entity_code).to eq(default_entity_code)
      end

      describe 'when the user pass the entity_code' do
        let(:server) { described_class.new(entity_code: entity_code) }

        let(:entity_code) { 'entity_code' }

        it 'uses the entity_code' do
          expect(server.entity_code).to eq(entity_code)
        end
      end

      describe 'when there is no ENV set' do
        it 'raises an argument error' do
          ENV.delete('CS_ENTITY_CODE')
          expect { server.entity_code }.to raise_error(KeyError)
        end
      end
    end

    describe '#wsdl_url' do
      let(:server) { described_class.new }

      it 'uses CS_WSDL_URL as default value' do
        expect(server.wsdl_url).to eq(default_wsdl_url)
      end

      describe 'when the user pass the wsdl_url' do
        let(:server) { described_class.new(wsdl_url: wsdl_url) }

        let(:wsdl_url) { 'wsdl_url' }

        it 'uses the wsdl_url' do
          expect(server.wsdl_url).to eq(wsdl_url)
        end
      end

      describe 'when there is no ENV set' do
        it 'raises an argument error' do
          ENV.delete('CS_WSDL_URL')
          expect { server.wsdl_url }.to raise_error(KeyError)
        end
      end
    end
  end
end
