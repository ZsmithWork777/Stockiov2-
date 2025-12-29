module Api
  module V1
    class ItemsController < BaseController
      before_action :authenticate_api_user

      def index
        items = current_user.items
        render_success(data: items)
      end

      private

      def authenticate_api_user
        token = request.headers["Authorization"]&.split(" ")&.last
        @current_user = User.find_by(api_token: token)

        render_error(message: "Unauthorized", status: :unauthorized) unless @current_user
      end

      def current_user
        @current_user
      end
    end
  end
end
