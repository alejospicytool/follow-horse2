class ConversationsController < ApplicationController
  before_action :sub_links

  def conversaciones_activas
    @users = User.all
    @conv1 = Conversation.where(sender_id: current_user.id).where(archive: false)
    @conv2 = Conversation.where(recipient_id: current_user.id).where(archive: false)
    @conversations = @conv1 + @conv2
    @conv = @conversations.select { |conv| conv.messages.last != nil}
    @conv_ordered = @conv.sort_by { |conv| conv.messages.last.created_at }.reverse

    # @conversation = Conversation.new
    @section_title = "Mensajes"
    @search = true
  end

  def conversaciones_archivadas
    @users = User.all
    @conv1 = Conversation.where(sender_id: current_user.id).where(archive: true)
    @conv2 = Conversation.where(recipient_id: current_user.id).where(archive: true)
    @conversations = @conv1 + @conv2
    @conv = @conversations.select { |conv| conv.messages.last != nil}
    @conv_ordered = @conv.sort_by { |conv| conv.messages.last.created_at }.reverse

    # @conversation = Conversation.new
    @section_title = "Mensajes"
    @search = true
  end

  def show
    @conversation = Conversation.find(params[:id])
    @dots = true
    # Establishing the name of the conversation
    @mensaje_automatico = params[:mensaje_automatico] if params[:mensaje_automatico]
    if @conversation.sender_id == current_user.id
      @user = User.find(@conversation.recipient_id)
      @section_title = @user.nombre + ' ' + @user.apellido
      @image_title = "profile-icon.png"
    else
      @user = User.find(@conversation.sender_id)
      @section_title = @user.nombre + ' ' + @user.apellido
      @image_title = "profile-icon.png"
    end

    # Conversation messages
    @messages = @conversation.messages
    @message = Message.new

    # Marking the messages as read
    @messages.each do |message|
      if message.user_id != current_user.id
        message.read = true
        message.save!

        notification = Notification.find_by(message_id: message.id)
        notification.destroy if notification.present?
      end
    end
  end

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    if params[:horse_id]
      @horse = Horse.find(params[:horse_id])
      puts "Este es el caballo: #{@horse}"
      # Metodo que haga post de un mensaje con la info del caballo
      message_link = horse_show_path(@horse)
      @mensaje_automatico = "Hola, estoy interesado en el caballo #{@horse.name}."
    end
    redirect_to conversacion_show_path(@conversation, mensaje_automatico: @mensaje_automatico)
  end

  def archivar
    @conversation = Conversation.find(params[:id])
    @conversation.archive = true
    if @conversation.save
      redirect_to conversaciones_archivadas_path
    else
      redirect_to conversaciones_activas_path, notice: "No se pudo archivar la conversacion, por favor intente nuevamente"
    end
  end

  def desarchivar
    @conversation = Conversation.find(params[:id])
    @conversation.archive = false
    if @conversation.save
      redirect_to conversaciones_activas_path
    else
      redirect_to conversaciones_archivadas_path, notice: "No se pudo desarchivar la conversacion, por favor intente nuevamente"
    end
  end

  def destroy
    @conversation = Conversation.find(params[:id])
    if @conversation.destroy
      redirect_to conversaciones_activas_path
    else
      render :conversacion_show, status: :unprocessable_entity
    end
  end

  def sub_links
    @sub_links = [
      {title: "Activos", path: conversaciones_activas_path},
      {title: "Archivados", path: conversaciones_archivadas_path}
    ]
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
