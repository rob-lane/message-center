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
    render_exception('Missing recipients') unless params[:message][:recipients]

    collect_recip_ids!

    @message = Message.create(message_params)
    if @message && @message.valid?
      redirect_to api_v1_message_path(@message)
    else
      render_exception("Message failed to save")
    end

  end

  private
    def message_params
      params.require(:message).permit :subject, :body, recipient_ids: []
    end

    def contact_params
      params.require(:message).require(:contact).permit :email
    end

    def collect_recip_ids!
      recip_ids = params[:message][:recipients].
          map do |recip|
        (Contact.find_by_email(recip) || Contact.create(contact_params)).id
      end
      params[:message][:recipient_ids] = recip_ids
    end
end
