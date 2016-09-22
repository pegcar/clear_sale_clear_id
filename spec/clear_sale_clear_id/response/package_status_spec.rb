require 'spec_helper'

module ClearSaleClearId
  module Response
    describe PackageStatus do
      describe '#new' do
        describe 'when the xml string is passed' do
          let(:request_body) { 'foo' }
          let(:response_body) do
            "<ClearID>
               <PackageStatus>
                 <TransactionID>transaction_id</TransactionID>
                 <StatusCode>0</StatusCode>
                 <Message>message</Message>
                 <Pedidos>
                   <Pedido>
                     <ID>order_id</ID>
                     <Score>score</Score>
                     <Status>status</Status>
                     <URLQuestionario>quiz_url</URLQuestionario>
                   </Pedido>
                 </Pedidos>
               </PackageStatus>
             </ClearID>"
          end

          let(:package_status) do
            described_class.new(request_body, response_body)
          end

          it 'sets the transaction id' do
            expect(package_status.transaction_id).to eq('transaction_id')
          end

          it 'sets the status code' do
            expect(package_status.status_code).to eq(0)
          end

          it 'sets the message' do
            expect(package_status.message).to eq('message')
          end

          describe '#orders' do
            it 'sets an order object to each order on xml' do
              expect(package_status.orders.size).to eq(1)
            end

            it 'each order is a ClearSaleClearId::Response::Order' do
              expect(package_status.orders.first.class).to eq(Order)
            end

            describe 'each order' do
              let(:order) { package_status.orders.first }

              it 'sets the order id' do
                expect(order.id).to eq('order_id')
              end

              it 'sets the scrore' do
                expect(order.score).to eq('score')
              end

              it 'sets the status' do
                expect(order.status).to eq('status')
              end

              it 'sets the quiz url' do
                expect(order.quiz_url).to eq('quiz_url')
              end
            end
          end

          describe 'when the transaction respond with error' do
            let(:request_body) { 'foo' }
            let(:response_body) do
              <<-EOT
<?xml version='1.0' encoding='UTF-8'?>
<ClearID>
   <PackageStatus>
      <TransactionID>c887638e-5979-414f-8b39-92494fc195b9</TransactionID>
      <StatusCode>4</StatusCode>
      <Message>message_foo_bar</Message>
   </PackageStatus>
</ClearID>'
              EOT
            end

            it 'sets the orders array to empty array' do
              expect(package_status.orders).to eq([])
            end

            it 'sets the status code' do
              expect(package_status.status_code).to eq(4)
            end
          end
        end
      end
    end
  end
end
