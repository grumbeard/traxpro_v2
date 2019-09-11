const toggleBoxesBlue = () => {
  const boxes = document.querySelectorAll('.box');
  if (boxes) {
    boxes.forEach((box) => {
      box.addEventListener('click', (event) => {
        event.currentTarget.classList.toggle('blue');
        const xField = document.getElementById('issue_x_coordinate');
        xField.value = box.dataset.row;
        const yField = document.getElementById('issue_y_coordinate');
        yField.value = box.dataset.col;
        console.log(`${box.dataset.row} ${box.dataset.col}`);
      });
    });
  }
}

export { toggleBoxesBlue };

const pinIssue = () => {
  const boxes = document.querySelectorAll('.box');
  if (boxes) {
    boxes.forEach((box) => {
      box.addEventListener('click', (event) => {
        const selectedBox = event.currentTarget;
        boxes.forEach((box) => {
          box.innerHTML = "";
        });
        selectedBox.insertAdjacentHTML('afterbegin',
        "<i class='fas fa-exclamation-triangle text-pink'></i>");
        const xField = document.getElementById('issue_x_coordinate');
        xField.value = selectedBox.dataset.row;
        const yField = document.getElementById('issue_y_coordinate');
        yField.value = selectedBox.dataset.col;
      });
    });
  }
}

export { pinIssue };
