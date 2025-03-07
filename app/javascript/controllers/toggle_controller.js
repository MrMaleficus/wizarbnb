import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["content"]

  toggle() {
    const content = this.contentTarget;

    if (content.classList.contains("d-none")) {
      content.classList.remove("d-none");
      content.style.height = "0px";
      content.offsetHeight;
      content.style.transition = "height 0.3s ease";
      content.style.height = content.scrollHeight + "px";

      content.addEventListener("transitionend", function handler() {
        content.style.height = null;
        content.style.transition = null;
        content.removeEventListener("transitionend", handler);
      });
    } else {
      content.style.height = content.scrollHeight + "px";
      content.offsetHeight;
      content.style.transition = "height 0.3s ease";
      content.style.height = "0px";

      content.addEventListener("transitionend", function handler() {
        content.classList.add("d-none");
        content.style.height = null;
        content.style.transition = null;
        content.removeEventListener("transitionend", handler);
      });
    }
  }
}
