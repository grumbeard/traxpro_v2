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
    checkboxDiv.insertAdjacentHTML('afterbegin', `<div data-subcategory="${subcategory.id}" class="form-check rounded-card subcategory-card"><input type="checkbox" data-input="${subcategory.id}" name="subcategories[]" value=${subcategory.id} hidden="true"><label class="form-check-label">${subcategory.name}</label></div>` );
  });
  const subcategoryCheckboxes = document.querySelectorAll('.subcategory-card');
  subcategoryCheckboxes.forEach((subcategoryCheckbox) => {
    subcategoryCheckbox.addEventListener('click', (event) => {
      const selectedSubcategory = event.currentTarget;
      selectedSubcategory.classList.toggle('subcategory-card-selected');
      selectedSubcategory.classList.toggle('subcategory-card');
      const id = event.currentTarget.dataset.subcategory;
      const checkbox = document.querySelector(`[data-input="${id}"]`);
      if (checkbox.checked === true) {
        checkbox.checked = false;
      } else {
        checkbox.checked = true;
      }
    });
  });
}

export { filterSubCategories };
