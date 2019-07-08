class FoodService
  def search(query)
    get_json('/ndb/search', {q: query, max: 10})
  end

  private

  def get_json(url, params = {})
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.nal.usda.gov') do |f|
      f.params['api_key'] = ENV['gov-data-api-key']
      f.adapter Faraday.default_adapter
    end
  end
end
