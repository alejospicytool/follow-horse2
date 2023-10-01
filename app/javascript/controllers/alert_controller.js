import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.dismiss()
  }

  dismiss() {
    const alertElement = this.element;
    const bootstrapAlert = new bootstrap.Alert(alertElement);

    setTimeout(() => {
      bootstrapAlert.close();
    }, 4000);
  }
}
