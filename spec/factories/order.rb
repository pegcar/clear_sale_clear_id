module ClearSaleClearId
  FactoryGirl.define do
    factory :order, class: ClearSaleClearId::Order do
      id 42
      channel_id 'SITE'
      instalments 1
      delivery_days 1
      origin 'web'
      status Order::STATUS_NEW
      observation 'obs'
      b2b_or_b2c 'B2C'
      delivery_amount 0
      created_at Time.new(2016, 07, 02, 14, 30, 51)

      association :user, factory: :user, strategy: :build
      association :address, factory: :address, strategy: :build
      phones { build_list(:phone, 1) }
      payments { build_list(:payment, 1) }

      trait :malicious do
        items { build_list(:order_item, 2) }
        total_amount 157
      end

      trait :not_malicious do
        items { build_list(:order_item, 2, :cheap) }
        total_amount 50
      end
    end
  end
end
