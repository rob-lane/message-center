class Api::V1::MessagesController < Api::V1::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :render_exception
  before_action :collect_recip_ids!, only: :create

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

    def contact_params(email)
      params[:message][:contact] = { email: email }
      params.require(:message).require(:contact).permit :email
    end

    def collect_recip_ids!
      params[:message][:recipient_ids] = []
      params[:message][:recipients].each do |email|
        existing = Contact.find_by_email(email)
        new = Contact.create(contact_params(email)) if existing.nil?
        params[:message][:recipient_ids] << (existing.nil? ? new.id : existing.id)
      end
    end
end
