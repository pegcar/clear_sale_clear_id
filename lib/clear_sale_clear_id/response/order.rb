module ClearSaleClearId
  module Response
    class Order
      attr_accessor :id, :score, :status, :quiz_url

      def initialize(attributes = {})
        attributes = attributes.fetch('Pedido', {})

        self.id = attributes['ID']
        self.score = attributes['Score']
        self.status = attributes['Status']
        self.quiz_url = attributes['URLQuestionario']
      end

      def approved?
        %w(APA APQ).include?(self.status)
      end

      def reproved?
        %w(RPQ RPP RPA QNG).include?(self.status)
      end

      def needs_quiz?
        %w(PAV).include?(self.status)
      end
    end
  end
end
