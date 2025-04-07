// app/javascript/controllers/mark_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["checkbox"]

  toggle(event) {
    this.element.submit()
  }
}
