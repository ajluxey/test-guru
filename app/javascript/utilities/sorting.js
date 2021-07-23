document.addEventListener('turbolinks:load', () => {
  let tables = document.querySelectorAll('table');
  tablesWithSort = []
  tables.forEach((table) => {
    sorterHeaders = table.querySelectorAll('.sort-by-this');
    if (sorterHeaders) {
      tablesWithSort.push(new TableWithSort(table, sorterHeaders))
    }
  });
  console.log(tablesWithSort);
});


class TableWithSort {
  constructor(table, sorterHeaders) {
    this.tableInHtml = table;
    this.content = table.querySelector('tbody');
    this.sorterHeaders = [];
    sorterHeaders.forEach((sorterHeader) => this.sorterHeaders.push(new SorterHeader(sorterHeader, this)));
  }

  clearHeadersOtherThan(header) {
    sorterHeaders.forEach((anotherHeader) => {
      console.log(anotherHeader);
      console.log(header);
      if (anotherHeader !== header) {
        console.log('ne ravni');
        anotherHeader.querySelector('.octicon-arrow-up').classList.add('hide');
        anotherHeader.querySelector('.octicon-arrow-down').classList.add('hide');
      }
    });
  }
}


class SorterHeader {
  constructor(header, table) {
    this.headerInHtml = header;
    this.table = table;
    this.headerInHtml.addEventListener('click', () => { this.sortRow(this) });
  }

  sortRow() {
    this.table.clearHeadersOtherThan(this.headerInHtml);

    let rows = this.table.content.querySelectorAll('tr');
    let sortedRows = Array.from(rows);
    if (this.headerInHtml.querySelector('.octicon-arrow-up').classList.contains('hide')) {
      sortedRows.sort(this.compareRowsAsc.bind(this));
      this.headerInHtml.querySelector('.octicon-arrow-up').classList.remove('hide');
      this.headerInHtml.querySelector('.octicon-arrow-down').classList.add('hide');
    } else {
      sortedRows.sort(this.compareRowsDesc.bind(this));
      this.headerInHtml.querySelector('.octicon-arrow-up').classList.add('hide');
      this.headerInHtml.querySelector('.octicon-arrow-down').classList.remove('hide');
    }
    sortedTableContent = document.createElement('tbody');
    sortedRows.forEach(tr => sortedTableContent.appendChild(tr));
    this.table.tableInHtml.replaceChild(sortedTableContent, this.table.content);
    this.table.content = sortedTableContent;
  }

  compareRowsAsc(row1, row2) {
    let testTitle1 = row1.querySelectorAll('td').item(this.headerInHtml.cellIndex).textContent;
    let testTitle2 = row2.querySelectorAll('td').item(this.headerInHtml.cellIndex).textContent;
  
    if (testTitle1 < testTitle2) { return -1 }
    if (testTitle1 > testTitle2) { return 1 }
    return 0;
  }

  compareRowsDesc(row1, row2) {
    return this.compareRowsAsc(row1, row2) * -1;
  }
}
