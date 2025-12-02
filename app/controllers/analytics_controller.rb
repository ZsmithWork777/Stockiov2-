class AnalyticsController < ApplicationController
  def index
    @items_count = Item.count
    @total_quantity = Item.sum(:quantity)
    @most_common_item = Item.group(:name).count.max_by { |k, v| v }&.first
  end
end
