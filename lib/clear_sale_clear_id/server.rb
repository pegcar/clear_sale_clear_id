require 'savon'

module ClearSaleClearId
  class Server
    attr_accessor :service_url, :wsdl_url, :entity_code, :savon_client

    def initialize(
      service_url: ENV.fetch('CS_SERVICE_URL'),
      wsdl_url: ENV.fetch('CS_WSDL_URL'),
      entity_code: ENV.fetch('CS_ENTITY_CODE'),
      savon_client: nil
    )
      self.service_url = service_url
      self.wsdl_url = wsdl_url
      self.entity_code = entity_code
      self.savon_client = savon_client || Savon.client(wsdl: wsdl_url)
    end

    def submit_info(order)
      request_body = order.to_xml

      response = savon_client.call(
        :submit_info, message: {
          'entityCode' => '4AFBF7B6-32B9-4527-A148-0F01BB72AB94',
          'xmlDados' => request_body
        }
      )
      response_body = response.body

      Response::PackageStatus.new(
        request_body,
        extract_response_xml('submit_info', response_body)
      )
    end

    private

    def extract_response_xml(method, response)
      results = response.fetch(:"#{method.snakecase}_response", {})
      results.fetch(:"#{method.snakecase}_result", {})
    end
  end
end
