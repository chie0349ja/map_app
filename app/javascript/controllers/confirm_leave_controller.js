import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["homeLink"]

  connect() {
    console.log("ConfirmLeaveController connected")
  }

  confirmHome(event) {
    if (!confirm("編集中の内容は保存されませんが、HOMEに戻りますか？")) {
      event.preventDefault()
    }
  }
}