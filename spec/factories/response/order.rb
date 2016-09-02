module ClearSaleClearId
  module Response
    FactoryGirl.define do
      factory(
        :order_response, class: ClearSaleClearId::Response::Order
      ) do
        id 42
        score 520
        quiz_url nil

        trait :approved do
          status 'APA'
        end

        trait :needs_quiz do
          status 'PAV'
        end

        trait :approved_by_quiz do
          status 'APQ'
        end

        trait :reproved_by_quiz do
          status 'RPQ'
        end

        trait :reproved_by_politic do
          status 'RPP'
        end

        trait :reproved do
          status 'RPA'
        end

        trait :quiz_not_generated do
          status 'QNG'
        end
      end
    end
  end
end
