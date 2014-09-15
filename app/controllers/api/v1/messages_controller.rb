class Api::V1::MessagesController < Api::V1::BaseController
  rescue_from ActiveRecord::RecordNotFound, with: :render_exception

  before_action :collect_recipient_ids, only: [:create, :forward]
  before_action :find_message, only: [:show, :update, :destroy, :forward]

  def index
    @messages = Message.order('created_at DESC')
    respond_with @messages
  end

  def show
    respond_with @message
  end

  def create
    if params[:message].nil? || params[:message][:recipients].nil?
      return render_exception('Missing recipients')
    end

    @message = Message.create(message_params)
    if @message && @message.valid?
      @message.send_to_recipients
      redirect_to api_v1_message_path(@message)
    else
      render_exception("Message failed to save")
    end
  end

  def update
    if params[:message] && params[:message][:new_recipients]
      ## Fetch or create new recipient contacts
      collect_recipient_ids(params[:message][:new_recipients])
      ## Include existing ids for update
      params[:message][:recipient_ids].concat(@message.recipient_ids).uniq
      ## Send to new recipients
      @message.send_to_recipients(params[:message][:new_recipients])
    end

    if @message.update(message_params)
      respond_with @message
    else
      render_exception("Failed to update message")
    end
  end

  def destroy
    if @message.destroy
      respond_with message: 'success!'
    else
      render_exception("Failed to destroy message")
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

    def collect_recipient_ids(recipients = nil)
      params[:message][:recipient_ids] = []
      recipients ||= params[:message][:recipients]

      recipients.each do |email|
        existing = Contact.find_by_email(email)
        new = Contact.create(contact_params(email)) if existing.nil?
        params[:message][:recipient_ids] << (existing.nil? ? new.id : existing.id)
      end
    end

    def find_message
      @message = Message.find(params[:id])
      return render_exception("Invalid message ID") if @message.nil?
      return @message
    end
end
