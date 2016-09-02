require 'spec_helper'

module ClearSaleClearId
  describe OrderXml do
    let(:order) { build(:order, :malicious) }

    it 'renders a xml with the right attributes' do
      fixture_xml = Nokogiri::XML::Document.parse(
        File.read('./spec/support/fixtures/clear_id_example.xml')
      )
      expect(
        Nokogiri::XML::Document.parse(order.to_xml)
      ).to be_equivalent_to(fixture_xml)
    end
  end
end
