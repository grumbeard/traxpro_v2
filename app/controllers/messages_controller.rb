class MessagesController < ApplicationController
  before_action :set_issue, only: [:index, :new, :create]

  def index
    @messages = @issue.messages.order(created_at: :asc)
    @message = Message.new
  end

  def new
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.issue = @issue
    if @message.save
      redirect_to issue_messages_path(@issue) # write comment
    else
      render 'new'
      # write error message
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :photo)
  end

  def set_issue
    @issue = Issue.find(params[:issue_id])
  end
end
