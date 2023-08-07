import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static targets = ["notifications"]

  connect() {
    console.log("Connected to notification controller")

    this.channel = createConsumer().subscriptions.create(
      { channel: "NotificationChannel", id: "notification_channel" },
      { received: data => this.#insertNotification(data)}
    )

    console.log(`Subscribe to the notification channel.`)
  }

  #insertNotification(data) {
     // Creating the whole message from the `data.message` String
     const notificationElement = this.#buildNotificationElement(data.notification)

     // Inserting the `message` in the DOM
     this.notificationsTarget.insertAdjacentHTML("beforeend", notificationElement)
     this.notificationsTarget.scrollTo(0, this.notificationsTarget.scrollHeight)
    //  let items = document.querySelectorAll(".message-new");
    //  let last = items[items.length-1];
    //  last.scrollIntoView();
   }

   #buildNotificationElement(notification) {
    return `${notification}`
  }
}
