import { Controller } from "@hotwired/stimulus";
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["input", "price"];

  connect() {
    const reservedDates = JSON.parse(this.data.get("reservedDates") || "[]");
    flatpickr(this.inputTarget, {
      mode: "range",
      dateFormat: "Y-m-d",
      disable: reservedDates,
      minDate: "today",
      onChange: this.updatePrice.bind(this)
    });
  }

  updatePrice(selectedDates) {
    let days = 0;
    if (selectedDates.length === 1) {
      // Sélection unique = 1 jour de travail
      days = 1;
    } else if (selectedDates.length === 2) {
      const [startDate, endDate] = selectedDates;
      const diff = (endDate - startDate) / (1000 * 60 * 60 * 24);
      // Si l'intervalle est d'une journée ou moins, c'est 1 jour ; sinon, on exclut le dernier jour
      days = diff <= 1 ? 1 : diff - 1;
    }
    const basePrice = parseFloat(this.data.get("basePrice"));
    const totalPrice = days * basePrice;
    this.priceTarget.textContent = `${totalPrice.toFixed(2)} € (${days} jour ${days > 1 ? "s" : ""})`;
  }

  submit(event) {
    event.preventDefault();
  }
}
