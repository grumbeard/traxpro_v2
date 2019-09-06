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
      selectedCategoryId = selectedCategory.dataset['id'];
      filterSubCategories(selectedCategoryId);
    });
  });
};

if (document.querySelector('[data-issues]')) {
    const map_all_pins_checker = document.querySelector('[data-issues]').dataset.issues
    pinAllIssues()
  }
