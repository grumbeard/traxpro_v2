import "bootstrap";
import { toggleBoxesBlue } from '../pages/map';
import { pinAllIssues } from '../pages/map_pin_issue';
import { filterSubCategories } from '../filters/filter_subcategories';

const map_page_checker = document.querySelectorAll('.box');
if (map_page_checker !== null) { toggleBoxesBlue(); };


const categories = document.querySelectorAll('[data-id]');
if (categories !== null) {
  let selectedCategoryId = null;
  categories.forEach((category) => {
    category.addEventListener('click', (event) => {
      const selectedCategory = event.currentTarget;
      selectedCategory.classList.toggle('category-card-selected');
      selectedCategory.classList.toggle('category-card');
      selectedCategoryId = selectedCategory.dataset['id'];
      filterSubCategories(selectedCategoryId);
    });
  });
};

const sliderBtnContainer = document.querySelector('.slider-btn-container');
const titleField = document.getElementById('issue_title');
const mapField = document.getElementById('issue_map_id');
if ((titleField.value === "") || (mapField.value === "")) {
  console.log('it is empty!');
  sliderBtnContainer.insertAdjacentHTML('beforeend', "<a href='#form-slider' role='button' data-slide='next'><div class='emerald action-btn'><p>Continue</p><span class='sr-only'>Next</span></div>");
}

if ((titleField.value !== "") && (mapField.value !== "")) {
  sliderBtnContainer.innerHTML = "";
}

if (document.querySelector('[data-issues]')) {
    const map_all_pins_checker = document.querySelector('[data-issues]').dataset.issues
    pinAllIssues()
  }
