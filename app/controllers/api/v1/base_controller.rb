class Api::V1::BaseController < ApplicationController
  respond_to :json

  private
    def render_exception(exception)
      render json: {error: exception.to_s}, status: 500
    end
end