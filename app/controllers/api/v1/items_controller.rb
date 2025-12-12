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
        item = Item.new(item_params)

        if item.save
          render_success(data: item, status: :created)
        else
          render_error(message: item.errors.full_messages)
        end
      end

      # PATCH/PUT /api/v1/items/:id
      def update
        item = Item.find(params[:id])

        if item.update(item_params)
          render_success(data: item)
        else
          render_error(message: item.errors.full_messages)
        end
      end

      # DELETE /api/v1/items/:id
      def destroy
        item = Item.find(params[:id])
        item.destroy
        render_success(data: { message: "Item deleted" })
      end

      # POST /api/v1/items/import
      def import
        return render_error(message: "No CSV file uploaded") if params[:file].nil?

        begin
          Item.import(params[:file])

          respond_to do |format|
            format.json { render_success(data: { message: "Items imported successfully" }) }
            format.html { redirect_to items_path, notice: "CSV imported successfully!" }
          end
        rescue => e
          render_error(message: e.message)
        end
      end

      # GET /api/v1/items/export
      def export
        send_data Item.to_csv,
                  filename: "items-#{Date.today}.csv",
                  type: "text/csv"
      end

      private

      def item_params
        params.require(:item).permit(:name, :quantity, :category_id)
      end
    end
  end
end
