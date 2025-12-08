module Api
  module V1
    class ItemsController < BaseController

      # GET /api/v1/items
      def index
        items = Item.all.order(:name)
        render_success(data: items)
      end

      # GET /api/v1/items/:id
      def show
        item = Item.find(params[:id])
        render_success(data: item)
      end

      # POST /api/v1/items
      def create
        service = ItemCreator.new(item_params)

        if service.call
          render_success(data: service.item, status: :created)
        else
          render_error(message: service.errors)
        end
      end

      # PATCH/PUT /api/v1/items/:id
      def update
        item = Item.find(params[:id])
        service = ItemUpdater.new(item, item_params)

        if service.call
          render_success(data: service.item)
        else
          render_error(message: service.errors)
        end
      end

      # DELETE /api/v1/items/:id
      def destroy
        item = Item.find(params[:id])
        item.destroy
        render_success(data: { message: "Item deleted" })
      end
#-----
#CSV Import

#POST /api/v1/items/import
def import
    return render_error(message: "No CSV file uploaded") if params[:file].nil?

    begin
        Item.import(params[:file])
        render_success(data: {message: "Item Imported successfully"})
    rescue => e
        render_error(message: e.message)
    end
end
#CSV Export
def export
  send_data Item.to_csv,
  filename: "items-#{Date.today}.csv",
  type: "text/csv"
end
#------
      private

      def item_params
        params.require(:item).permit(:name, :quantity, :category_id)
      end
    end
  end
end
