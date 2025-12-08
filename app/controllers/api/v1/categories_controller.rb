module Api
  module V1
    class CategoriesController < BaseController

      def index
        categories = Category.all.order(:name)
        render_success(data: categories)
      end

      def show
        category = Category.find(params[:id])
        render_success(data: category)
      end

      def create
        category = Category.new(category_params)

        if category.save
          render_success(data: category, status: :created)
        else
          render_error(message: category.errors.full_messages)
        end
      end

      def update
        category = Category.find(params[:id])

        if category.update(category_params)
          render_success(data: category)
        else
          render_error(message: category.errors.full_messages)
        end
      end

      def destroy
        category = Category.find(params[:id])
        category.destroy
        render_success(data: { message: "Category deleted" })
      end

      private

      def category_params
        params.require(:category).permit(:name)
      end

    end
  end
end
