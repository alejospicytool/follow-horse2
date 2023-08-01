import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="capitalize"
export default class extends Controller {
  static targets = ["input"];

  connect() {
    // console.log("Connected capitalize controller")
    this.inputTargets.forEach((input) => {
      input.addEventListener("input", this.capitalizeFirstLetter);
      input.addEventListener("keyup", this.capitalizeFirstLetter);
    });
  }

  disconnect() {
    this.inputTargets.forEach((input) => {
      input.removeEventListener("input", this.capitalizeFirstLetter);
      input.removeEventListener("keyup", this.capitalizeFirstLetter);
    });
  }

  capitalizeFirstLetter(event) {
    const input = event.target;
    const currentValue = input.value;
    const capitalizedValue = currentValue.charAt(0).toUpperCase() + currentValue.slice(1);
    input.value = capitalizedValue;
  }
}
