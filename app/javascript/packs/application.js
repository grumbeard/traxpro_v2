import "bootstrap";
// import "printAllSubCategories" from '../filters/categorization_filter_subcategories';

// printAllSubCategories();

let selectedCategoryId = null;

const categories = document.querySelectorAll('[data-id]');
categories.forEach((category) => {
  category.addEventListener('click', (event) => {
    const selectedCategory = event.currentTarget;
    selectedCategoryId = selectedCategory.dataset['id'];
    printFilteredSubCategories(selectedCategoryId);
  });
});

const printFilteredSubCategories = (selectedCategoryId) => {
  const data = document.querySelector('[data-subcategories]');
  const subCategoriesJSON = data.dataset['subcategories'];
  const allSubCategories = JSON.parse(subCategoriesJSON);
  // allSubCategories.forEach((subCategory) => {
  //   console.log(subCategory.category_id);
  // });
  const filteredSubCategories = allSubCategories.filter((sub) => {
    return sub.category_id === parseInt(selectedCategoryId)
  });
  const checkboxDiv = document.getElementById('category-checkbox');
  checkboxDiv.innerHTML = "";
  filteredSubCategories.forEach((subcategory) => {
    checkboxDiv.insertAdjacentHTML('afterbegin', `<div class="form-check"><input type="checkbox" name="subcategories[]" value="${subcategory.id}"><label class="form-check-label">${subcategory.name}</label></div>` );
  });
}
