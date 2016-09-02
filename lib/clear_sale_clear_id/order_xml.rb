require 'bigdecimal'

module ClearSaleClearId
  module OrderXml
    def to_xml
      builder.instruct!(:xml, version: '1.0', encoding: 'UTF-8')
      xml = builder.tag!('ClearID_Input') do |clear_id_node|
        clear_id_node.tag!('SessionID', user.session_id)
        clear_id_node.tag!('Pedido') do |order_node|
          build_order(order_node)
        end
      end

      xml.to_s
    end

    private

    def builder
      @builder ||= Builder::XmlMarkup.new(indent: 2)
    end

    def build_order(order_node)
      order_node.tag!('PedidoID', id)
      order_node.tag!('Data', created_at.strftime("%Y-%m-%dT%H:%M:%S"))
      order_node.tag!('Email', user.email)
      order_node.tag!('CanalID', channel_id)
      order_node.tag!('B2B_B2C', b2b_or_b2c)
      order_node.tag!('ValorFrete', format_currency(delivery_amount))
      order_node.tag!('ValorTotalItens', format_currency(items_price))
      order_node.tag!('ValorTotalPedido', format_currency(total_amount))
      order_node.tag!('QtdParcelas', instalments)
      order_node.tag!('PrazoEntrega', delivery_days)
      order_node.tag!('QtdItens', items_count)
      order_node.tag!('QtdFormasPagamento', 1) # TODO
      order_node.tag!('IP', user.ip)
      order_node.tag!('Observacao', observation)
      order_node.tag!('Status', status)
      order_node.tag!('Origem', origin)
      build_payment_info(order_node)
      build_delivery_info(order_node)

      order_node.tag!('Pagamentos') do |payments_node|
        payments.each do |payment|
          build_payment(payments_node, payment)
        end
      end
      build_items(order_node)
    end

    def build_items(parent_node)
      parent_node.tag!('Itens') do |items_node|
        items.each do |item|
          parent_node.tag!('Item') do |item_node|
            items_node.tag!('CodigoItem', item.id)
            items_node.tag!('NomeItem', item.description)
            items_node.tag!('ValorItem', format_currency(item.price))
            items_node.tag!('Quantidade', item.quantity)
            items_node.tag!('Generico', item.obs)
            items_node.tag!('CodigoCategoria', item.category_id)
            items_node.tag!('NomeCategoria', item.category)
          end
        end
      end
    end

    def build_payment_info(order_node)
      order_node.tag!('DadosCobranca') do |payment_info|
        payment_info.tag!('UsuarioID', user.id)
        payment_info.tag!('TipoUsuario', user.type)
        payment_info.tag!('DocumentoLegal1', user.document)
        payment_info.tag!('DocumentoLegal2', user.document1)
        payment_info.tag!('Nome', user.name)
        payment_info.tag!('Email', user.email)
        payment_info.tag!('Sexo', user.gender)
        payment_info.tag!('Nascimento', user.birthdate.strftime("%Y-%m-%dT%H:%M:%S"))
        build_address(payment_info)
        payment_info.tag!('Telefones') do |phones_node|
          phones.each do |phone|
            build_phone(phones_node, phone)
          end
        end
      end
    end

    def build_address(parent_node, tag_name = 'Endereco')
      parent_node.tag!(tag_name) do |address_node|
        address_node.tag!('Logradouro', address.street)
        address_node.tag!('Complemento', address.street1)
        address_node.tag!('Numero', address.number)
        address_node.tag!('Bairro', address.neighborhood)
        address_node.tag!('Cidade', address.city)
        address_node.tag!('UF', address.state)
        address_node.tag!('CEP', address.zipcode)
        address_node.tag!('Pais', address.country)
      end
    end

    def build_phone(parent_node, phone)
      parent_node.tag!('Telefone') do |phone_node|
        phone_node.tag!('Tipo', phone.type)
        phone_node.tag!('DDI', phone.ddi)
        phone_node.tag!('DDD', phone.ddd)
        phone_node.tag!('Numero', phone.number)
        phone_node.tag!('Ramal', phone.branch)
      end
    end

    def build_delivery_info(order_node)
      order_node.tag!('DadosEntrega') do |delivery_info|
        delivery_info.tag!('UsuarioID', user.id)
        delivery_info.tag!('TipoUsuario', user.type)
        delivery_info.tag!('DocumentoLegal1', user.document)
        delivery_info.tag!('DocumentoLegal2', user.document1)
        delivery_info.tag!('Nome', user.name)
        delivery_info.tag!('Email', user.email)
        delivery_info.tag!('Sexo', user.gender)
        delivery_info.tag!('Nascimento', user.birthdate.strftime("%Y-%m-%dT%H:%M:%S"))
        build_address(delivery_info)
        delivery_info.tag!('Telefones') do |phones_node|
          phones.each do |phone|
            build_phone(phones_node, phone)
          end
        end
      end
    end

    def build_payment(parent_node, payment)
      parent_node.tag!('Pagamento') do |payment_node|
        payment_node.tag!('NumeroSequencial', payment.sequential)
        payment_node.tag!('Data', payment.created_at.strftime("%Y-%m-%dT%H:%M:%S"))
        payment_node.tag!('Valor', format_currency(payment.amount))
        payment_node.tag!('TipoPagamentoID', payment.type)
        payment_node.tag!('QtdParcelas', payment.instalments)
        payment_node.tag!('HashNumeroCartao', payment.credit_card_hash)
        payment_node.tag!('BinCartao', payment.credit_card_bin)
        payment_node.tag!('Cartao4Ultimos', payment.credit_card_last_four)
        payment_node.tag!('TipoCartao', payment.credit_card_type)
        payment_node.tag!('DataValidadeCartao', payment.credit_card_expiration)
        payment_node.tag!('NomeTitularCartao', payment.credit_card_owner_name)
        payment_node.tag!('DocumentoLegal1', payment.document)
        build_address(payment_node, 'EnderecoCobranca')
      end
    end

    def format_currency(value)
      "%.2f" % BigDecimal.new(value).to_f
    end
  end
end
