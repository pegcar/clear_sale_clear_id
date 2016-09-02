module ClearSaleClearId
  FactoryGirl.define do
    factory :address, class: ClearSaleClearId::Address do
      street 'Brigadeiro Araujo'
      street1 'Casa Única'
      number 76
      neighborhood 'Freguesia do Ó'
      city 'São Paulo'
      state 'SP'
      zipcode '02733090'
      country 'Brasil'
    end
  end
end
