import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["acceptButton", "declineButton"];

  accept(event) {
    event.preventDefault();
    const bookingId = this.data.get("bookingId");

    fetch(`/bookings/${bookingId}/accept`, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      }
    })
      .then(response => {
        if (response.ok) return response.json();
        throw new Error("Erreur lors de l'acceptation");
      })
      .then(data => {
        this.acceptButtonTarget.disabled = true;
        this.declineButtonTarget.disabled = true;
        this.window.location.reload();
      })
      .catch(error => console.error("Erreur:", error));
  }

  decline(event) {
    event.preventDefault();
    const bookingId = this.data.get("bookingId");

    fetch(`/bookings/${bookingId}/decline`, {
      method: "POST",
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
        "Accept": "application/json"
      }
    })
      .then(response => {
        if (response.ok) return response.json();
        throw new Error("Erreur lors du refus");
      })
      .then(data => {
        this.acceptButtonTarget.disabled = true;
        this.declineButtonTarget.disabled = true;
        this.window.location.reload();
      })
      .catch(error => console.error("Erreur:", error));
  }
}