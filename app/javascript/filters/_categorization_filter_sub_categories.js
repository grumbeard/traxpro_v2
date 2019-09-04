require 'json'

const categories = document.querySelectorAll('[data-id]');
categories.addEventListener('click', (event) => {
  const selectedCategory = event.currentTarget;
  const selectedCategoryId = selectedCategory.dataset['id'];
  return selectedCategoryId;
});

const printAllSubCategories = () => {
  const data = document.querySelector('[data-subcategories]');
  const subCategoriesJSON = data.dataset['subcategories']
  const allSubCategories = JSON.parse(subCategoriesJSON)
  const filteredSubCategories = allSubCategories.filter(sub => {
    sub.category_id === selectedCategoryId;
  }
  console.log(filteredSubCategories);
}

export { printAllSubCategories };
