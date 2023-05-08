import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = ['count'];

  connect() {
    console.log("Connected to notification controller")

    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationsChannel" },
      { received: this.handleNotificationUpdate.bind(this)}
    )
  }

  handleNotificationUpdate(data) {
    const { conversationId, notificationCount } = data;
    const target = this.findTargetByConversationId(conversationId);

    if (target) {
      target.textContent = notificationCount;

      if (notificationCount > 0) {
        target.parentElement.parentElement.style.display = 'block';
      } else {
        target.parentElement.parentElement.style.display = 'none';
      }
    }
  }

  findTargetByConversationId(conversationId) {
    return this.countTargets.find((target) => {
      return target.dataset.conversationId === conversationId;
    });
  }
}
