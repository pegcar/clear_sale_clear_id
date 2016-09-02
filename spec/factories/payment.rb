module ClearSaleClearId
  FactoryGirl.define do
    factory :payment, class: ClearSaleClearId::Payment do
      sequential 1
      created_at Time.new(2016, 07, 02, 14, 30, 51)
      amount 157
      type 14
      instalments 1
      credit_card_hash '747417f2206148a3118d02f3adf20b5e4139baac'
      credit_card_bin 111111
      credit_card_type 3
      credit_card_last_four 1111
      credit_card_expiration '01/18'
      credit_card_owner_name 'Rafael S Almeida'
      document 36564860111
    end
  end
end

