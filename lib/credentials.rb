class Credentials
  def self.fetch
    { "username": ENV['USERNAME'], "apikey": ENV['API_KEY'] }
  end
end
