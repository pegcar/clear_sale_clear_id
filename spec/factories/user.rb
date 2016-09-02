module ClearSaleClearId
  FactoryGirl.define do
    factory :user, class: ClearSaleClearId::User do
      id 42
      session_id 'session_id'
      type 1
      document '43523311-1'
      document1 '36564860111'
      name 'Rafael Almeida'
      email 'dev@pegcar.com'
      gender 'M'
      birthdate '09/04/1987'
      ip '192.168.0.256'
      addresses []
      phones []
    end
  end
end
