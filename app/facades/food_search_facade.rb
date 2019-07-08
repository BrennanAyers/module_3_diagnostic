class FoodSearchFacade
  attr_reader :result_count

  def initialize(query)
    @food_json = food_search(query)
    @result_count = @food_json[:list][:total]
  end

  def food_search(query)
    food_service.search(query)
  end

  def results
    @food_json[:list][:item].map do |food|
      Food.new(food)
    end
  end

  private

  def food_service
    FoodService.new
  end
end
