class Api::V1::MessagesController < Api::V1::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :render_missing

  def index
    @messages = Message.order('created_at DESC')
    respond_with @messages
  end

  def show
    @message = Message.find(params[:id])
    respond_with @message
  end

  def create
    @message = Message.create(message_params)
    redirect_to api_v1_message_path(@message)
  end

  private
    def render_missing(exception)
      render json: {error: exception.to_s}, status: 404
    end

    def message_params
      params.require(:message).permit :subject, :body
    end
end
