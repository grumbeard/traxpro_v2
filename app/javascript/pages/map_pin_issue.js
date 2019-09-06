const pinAllIssues = () => {
  const boxes = document.querySelectorAll('.box');
  const issuesJSON = document.querySelector('[data-issues]').dataset.issues;
  const issues = JSON.parse(issuesJSON);
  issues.forEach((issue)=> {
    if (issue.x_coordinate !== null) {
      const boxToPin = document.querySelector(`[data-row='${issue.x_coordinate}']`).parentElement.querySelector(`[data-col='${issue.y_coordinate}']`)
      boxToPin.insertAdjacentHTML('afterbegin',
        `<a href='/issues/${issue.id}/messages'><i class='fas fa-exclamation-triangle text-pink'></i></a>`);
    }
  });
}

export { pinAllIssues };
