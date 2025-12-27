module Api
  module V1
    class BaseController < ApplicationController
      protect_from_forgery with: :null_session

      before_action :set_default_format
      before_action :authenticate_api_user

      private

      def set_default_format
        request.format = :json
      end

      def authenticate_api_user
        token = request.headers["Authorization"]&.split(" ")&.last
        @current_user = User.find_by(api_token: token)

        render_error(message: "Unauthorized", status: :unauthorized) unless @current_user
      end

      def current_user
        @current_user
      end

      def render_success(data:, status: :ok)
        render json: data, status: status
      end

      def render_error(message:, status: :unprocessable_entity)
        render json: { error: message }, status: status
      end
    end
  end
end
