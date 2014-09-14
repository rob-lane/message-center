class Api::V1::MessagesController < Api::V1::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :render_exception

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
    if @message && @message.valid?
      redirect_to api_v1_message_path(@message)
    else
      render_exception("Message failed to save")
    end

  end

  private
    def message_params
      params.require(:message).permit :subject, :body
    end
end
