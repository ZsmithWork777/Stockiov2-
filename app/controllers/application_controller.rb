module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session

      before_action :authenticate_api_user!
      before_action :set_default_format

      private

      def set_default_format
        request.format = :json
      end

      def authenticate_api_user!
        token = request.headers["Authorization"]&.split(" ")&.last
        @current_user = User.find_by(api_token: token)

        unless @current_user
          render json: { error: "Unauthorized" }, status: :unauthorized
        end
      end

      def current_user
        @current_user
      end
    end
  end
end
