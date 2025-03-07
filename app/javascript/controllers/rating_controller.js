import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["input", "star"];

  connect() {
    console.log("Rating controller connected"); // Vérifie que le contrôleur se charge
    this.updateStars(this.currentRating());
  }

  currentRating() {
    let rating = 0;
    this.inputTargets.forEach(input => {
      if (input.checked) {
        rating = parseInt(input.value, 10);
      }
    });
    return rating;
  }

  updateStars(rating) {
    this.starTargets.forEach(star => {
      const starValue = parseInt(star.dataset.value, 10);
      if (starValue <= rating) {
        star.classList.add("text-warning");
      } else {
        star.classList.remove("text-warning");
      }
    });
  }

  selectRating(event) {
    // Récupère la valeur depuis le dataset du label
    const rating = parseInt(event.currentTarget.dataset.value, 10);
    // Trouve et coche le bouton radio correspondant
    const input = this.inputTargets.find(i => parseInt(i.value, 10) === rating);
    if (input) {
      input.checked = true;
    }
    console.log("Rating selected:", rating);
    this.updateStars(rating);
  }

  highlightStars(event) {
    const rating = parseInt(event.currentTarget.dataset.value, 10);
    this.updateStars(rating);
  }

  resetStars(event) {
    this.updateStars(this.currentRating());
  }

  submit(event) {
    event.preventDefault();
  }
}
