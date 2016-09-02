require 'spec_helper'

module ClearSaleClearId
  module Response
    describe PackageStatus do
      describe 'when the xml string is passed' do
        let(:attributes_xml) do
          "<ClearID>
             <PackageStatus>
               <TransactionID>transaction_id</TransactionID>
               <StatusCode>status_code</StatusCode>
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

        let(:package_status) { described_class.new(attributes_xml) }

        it 'sets the transaction id' do
          expect(package_status.transaction_id).to eq('transaction_id')
        end

        it 'sets the status code' do
          expect(package_status.status_code).to eq('status_code')
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
      end
    end
  end
end
