// favorite_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["heart"]
  static values = { horse: Number }

  favorite() {
    const horseId = this.horseValue;
    const url = `/favorite_horse/${horseId}`
    
    fetch(url, {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'X-CSRF-Token': getMetaValue('csrf-token')
      },
      credentials: 'same-origin'
    }).then(response => response.json())
      .then(data => {
        this.updateUI(data.favorite_exists)
      })
  }

  updateUI(favoriteExists) {
    const heartElement = this.heartTarget
    if (favoriteExists) {
      heartElement.classList.add('fa-heart')  // Filled heart
      heartElement.classList.remove('fa-heart-o')  // Empty heart
    } else {
      heartElement.classList.add('fa-heart-o')  // Empty heart
      heartElement.classList.remove('fa-heart')  // Filled heart
    }
  }
}

function getMetaValue(name) {
  const element = document.head.querySelector(`meta[name="${name}"]`)
  return element.getAttribute("content")
}
