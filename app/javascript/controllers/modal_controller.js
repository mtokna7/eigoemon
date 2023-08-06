import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    this.element.style.display = 'none'
  }

  open() {
    this.element.style.display = 'block'
  }

  close() {
    this.element.style.display = 'none'
  }
}
