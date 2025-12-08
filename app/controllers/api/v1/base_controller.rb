module Api
    module V1
  class BaseController < ApplicationController
    protect_from_forgery with: :null_session

    # All API endpoints should return JSON
    before_action :set_default_format

    private

    def set_default_format
      request.format = :json
    end

    # Standard success response
    def render_success(data:, status: :ok)
      render json: data, status: status
    end

    # Standard error response
    def render_error(message:, status: :unprocessable_entity)
      render json: { error: message }, status: status
    end
  end
end
end
