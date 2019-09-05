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
