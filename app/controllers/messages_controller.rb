class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def create
    @message = Message.new(message_params)
    @conversation = Conversation.find(params[:conversation_id])
    @message.conversation = @conversation
    @message.user = current_user

    if @message.save
      ChatChannel.broadcast_to(
        @conversation,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.user.id
      )
      head :ok

      # Broadcast the updated notification count for all conversations
      @conv1 = Conversation.where(sender_id: current_user.id).where(archive: true)
      @conv2 = Conversation.where(recipient_id: current_user.id).where(archive: true)
      conversations = @conv1 + @conv2
      conversations.each do |conversation|
        conversation_id = conversation.id
        notification_count = calculate_notification_count(conversation_id, current_user.id)

        ActionCable.server.broadcast('conversations', { conversationId: conversation_id, notificationCount: notification_count })
      end

    else
      redirect_to conversation_show_path(@conversation)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id, :conversation_id)
  end

  def calculate_notification_count(conversation_id, current_user_id)
    # Logic to calculate the notification count for a conversation
    conversation = Conversation.find(conversation_id)
    unread_messages = conversation.messages.where(read: false).where.not(user_id: current_user.id)
    notification_count = unread_messages.count
    notification_count
  end
end
