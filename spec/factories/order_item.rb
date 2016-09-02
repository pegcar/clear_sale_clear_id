module ClearSaleClearId
  FactoryGirl.define do
    factory :order_item, class: ClearSaleClearId::OrderItem do
      id 110
      description 'Pikachu'
      trait :cheap do
        price 20
      end

      trait :expansive do
        price 220
      end

      price 220

      quantity 22
      obs 'OBS'
      category_id 110
      category 'Única'
    end
  end
end
