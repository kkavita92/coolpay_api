require './lib/api'

describe Api do
  let(:api_url) { 'https://jsonplaceholder.typicode.com' }
  subject(:api) { described_class.new(api_url) }

  describe('#handle_get_request') do
    it('does') do
      expect(api.handle_get_request('/todos/1')).to be_kind_of(Net::HTTPOK)
    end
  end
end
