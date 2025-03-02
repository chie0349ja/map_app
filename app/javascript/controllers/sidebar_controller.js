
// app/javascript/controllers/sidebar_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "sidebar" ]  //HTML 側の data-sidebar-target="sidebar" を自動的に取得し

  connect() {
    // コントローラが接続されたとき、ここが呼ばれる
    // 何か初期化したい処理があればここに書く
    // 例: console.log("Sidebar controller connected!")
  }

  toggle() {
    // sidebarTarget ( = this.sidebarTarget ) を開閉する
    this.sidebarTarget.classList.toggle('open')
  }
}