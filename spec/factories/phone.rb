module ClearSaleClearId
  FactoryGirl.define do
    factory :phone, class: ClearSaleClearId::Phone do
      type 0
      ddi 55
      ddd 11
      number '972653111'
      branch '11'
    end
  end
end
