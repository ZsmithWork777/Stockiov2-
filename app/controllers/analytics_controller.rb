class AnalyticsController < ApplicationController
  def index
    @items = Item.all

    @items_count = @items.count
    @total_quantity = @items.sum(:quantity)

    @avg_quantity =
      @items_count > 0 ? (@total_quantity / @items_count) : 0

    @lowest_item = @items.order(:quantity).first
    @highest_item = @items.order(quantity: :desc).first

    @stock_variance =
      if @lowest_item && @highest_item
        @highest_item.quantity - @lowest_item.quantity
      else
        0
      end
  end
end
