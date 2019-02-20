require './lib/http_client'

 describe HTTPClient do
  let(:url) { 'https://jsonplaceholder.typicode.com/todos/1' }
  subject(:http_client) { described_class.new(url) }


  describe('#setup_http') do
    before do
      @req = Net::HTTP::Get.new(http_client.request_uri)
    end

    it('returns a HTTP object') do
      expect(http_client.handle_request(@req)).to be_kind_of(Net::HTTPOK)
    end
  end
end
