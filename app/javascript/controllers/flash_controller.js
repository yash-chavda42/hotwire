import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  
  connect() {
    console.log("Flash controller connected ✅")

    this.removeAfterAnimation = this.removeAfterAnimation.bind(this)
    this.element.addEventListener("animationend", this.removeAfterAnimation)
  }

  disconnect() {
    this.element.removeEventListener("animationend", this.removeAfterAnimation)
  }

  removeAfterAnimation() {
    this.element.remove()
  }
}