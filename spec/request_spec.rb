require './lib/request'

 describe Request do

  describe('#build_post') do
    before do
      @body = {"username": "username","apikey": "apikey"}.to_json
      @request = described_class.build_post("/", @body)
    end

    it('creates a POST request') do
      expect(@request).to be_kind_of(Net::HTTP::Post)
    end

    it('request has credentials in its body') do
      expect(@request.body).to eq(@body)
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
end
