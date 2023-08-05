import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["modal"];

  connect() {
    console.log("probando turbo-modal controller");
  }

  hideModal() {
    this.element.parentElement.removeAttribute("src");
    this.element.remove();
  }

  submitEnd(e) {
    if (e.detail.success) {
      this.hideModal();
    }
  }

  closeWithKeyboard(e) {
    if (e.code == "Escape") {
      this.hideModal();
    }
  }

  // hide modal when clicking outside of modal
  // action: "click@window->turbo-modal#closeBackground"
  closeBackground(e) {
    // Verificar si el clic se originó fuera del sidebar
    if (e.target.classList.contains("modal-backdrop")) {
      this.hideModal();
    } else {
    }
  }
}
