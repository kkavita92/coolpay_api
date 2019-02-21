require './lib/request'

 describe Request do

  describe('#build_post') do
    before do
      @body = {"username": "username","apikey": "apikey"}
      @token = "xxxxxx"
      @request = described_class.build_post("/", @body, @token)
    end

    it('creates a POST request') do
      expect(@request).to be_kind_of(Net::HTTP::Post)
    end

    it('request has credentials in its body') do
      expect(@request.body['username']).to eq('username')
      expect(@request.body['apikey']).to eq('apikey')
    end

    it('request has token in its body') do
      expect(@request['Authorization']).to eq("Bearer #{@token}")
    end
  end

    describe('#build_get') do
      before do
        @token = "xxxxxx"
        @request = described_class.build_get("/", @token)
      end

      it('creates a GET request') do
        expect(@request).to be_kind_of(Net::HTTP::Get)
      end

      it('request has token in its body') do
        expect(@request['Authorization']).to eq("Bearer #{@token}")
      end
    end
end
