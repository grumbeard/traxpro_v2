import "bootstrap";
import { toggleBoxesBlue } from '../pages/map';

toggleBoxesBlue();

let selectedCategoryId = null;

const categories = document.querySelectorAll('[data-id]');
categories.forEach((category) => {
  category.addEventListener('click', (event) => {
    const selectedCategory = event.currentTarget;
    selectedCategoryId = selectedCategory.dataset['id'];
    filterSubCategories(selectedCategoryId);
  });
});

const filterSubCategories = (selectedCategoryId) => {
  const data = document.querySelector('[data-subcategories]');
  const subCategoriesJSON = data.dataset['subcategories'];
  const allSubCategories = JSON.parse(subCategoriesJSON);
  const filteredSubCategories = allSubCategories.filter((sub) => {
    return sub.category_id === parseInt(selectedCategoryId)
  });
  const checkboxDiv = document.getElementById('category-checkbox');
  checkboxDiv.innerHTML = "";
  filteredSubCategories.forEach((subcategory) => {
    checkboxDiv.insertAdjacentHTML('afterbegin', `<div class="form-check"><input type="checkbox" name="subcategories[]" value="${subcategory.id}"><label class="form-check-label">${subcategory.name}</label></div>` );
  });
}
