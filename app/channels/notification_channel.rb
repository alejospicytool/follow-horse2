class NotificationChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    channel = "notification_channel"
    stream_for channel
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
