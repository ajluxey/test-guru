document.addEventListener('turbolinks:load', () => {
  let control = document.querySelector('.sort-by-title');

  if (control) { control.addEventListener('click', sortRowsByTitle); }
});


function sortRowsByTitle() {
  let tableContent = document.querySelector('tbody');
  let rows = tableContent.querySelectorAll('tr');

  let sortedRows = Array.from(rows);
  if (this.querySelector('.opticon-arrow-up').classList.contains('hide')) {
    sortedRows.sort(compareRowsAsc);
    this.querySelector('.opticon-arrow-up').classList.remove('hide');
    this.querySelector('.opticon-arrow-down').classList.add('hide');
  } else {
    sortedRows.sort(compareRowsDesc);
    this.querySelector('.opticon-arrow-up').classList.add('hide');
    this.querySelector('.opticon-arrow-down').classList.remove('hide');
  }

  sortedTableContent = document.createElement('tbody');
  sortedRows.forEach(tr => sortedTableContent.appendChild(tr));
  tableContent.parentNode.replaceChild(sortedTableContent, tableContent)
}


function compareRowsAsc(row1, row2) {
  let testTitle1 = row1.querySelector('td').textContent;
  let testTitle2 = row2.querySelector('td').textContent;

  if (testTitle1 < testTitle2) { return -1 }
  if (testTitle1 > testTitle2) { return 1 }
  return 0;
}


function compareRowsDesc(row1, row2) {
  return compareRowsAsc(row1, row2) * -1;
}