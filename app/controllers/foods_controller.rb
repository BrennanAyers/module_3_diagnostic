class FoodsController < ApplicationController
  def index
    render locals: {
      facade: FoodSearchFacade.new(params[:q])
    }
  end
end
