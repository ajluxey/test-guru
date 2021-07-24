document.addEventListener('turbolinks:load', () => {
  const tables = document.querySelectorAll('table')
  tables.forEach((table) => {
    const sorterHeaders = table.querySelectorAll('.sort-by-this')
    if (sorterHeaders) new TableWithSort(table, sorterHeaders)
  })
})

export class TableWithSort {
  constructor (table, sorterHeaders) {
    this.tableInHtml = table
    this.content = table.querySelector('tbody')
    this.sorterHeaders = []
    sorterHeaders.forEach((sorterHeader) => this.sorterHeaders.push(new SorterHeader(sorterHeader, this)))
  }

  clearHeadersOtherThan (header) {
    this.sorterHeaders.forEach((anotherHeader) => {
      if (anotherHeader !== header) {
        anotherHeader.hideArrows()
      }
    })
  }
}

export class SorterHeader {
  constructor (header, table) {
    this.headerInHtml = header
    this.table = table
    this.headerInHtml.addEventListener('click', () => { this.sortRow(this) })
  }

  sortRow () {
    this.table.clearHeadersOtherThan(this.headerInHtml)

    const rows = this.table.content.querySelectorAll('tr')
    let sortedRows = Array.from(rows)
    if (this.headerInHtml.querySelector('.octicon-arrow-up').classList.contains('hide')) {
      sortedRows.sort(this.compareRowsAsc.bind(this))
      this.setUpArrow()
    } else {
      sortedRows.sort(this.compareRowsDesc.bind(this))
      this.setDownArrow();
    }
    let sortedTableContent = document.createElement('tbody')
    sortedRows.forEach(tr => sortedTableContent.appendChild(tr))
    this.table.tableInHtml.replaceChild(sortedTableContent, this.table.content)
    this.table.content = sortedTableContent
  }

  compareRowsAsc (row1, row2) {
    const testTitle1 = row1.querySelectorAll('td').item(this.headerInHtml.cellIndex).textContent
    const testTitle2 = row2.querySelectorAll('td').item(this.headerInHtml.cellIndex).textConten
    if (testTitle1 < testTitle2) { return -1 }
    if (testTitle1 > testTitle2) { return 1 }
    return 0
  }

  compareRowsDesc (row1, row2) {
    return this.compareRowsAsc(row1, row2) * -1
  }

  setUpArrow() {
    this.headerInHtml.querySelector('.octicon-arrow-up').classList.remove('hide')
    this.headerInHtml.querySelector('.octicon-arrow-down').classList.add('hide')
  }

  setDownArrow() {
    this.headerInHtml.querySelector('.octicon-arrow-up').classList.add('hide')
    this.headerInHtml.querySelector('.octicon-arrow-down').classList.remove('hide')
  }

  hideArrows () {
    this.headerInHtml.querySelector('.octicon-arrow-up').classList.add('hide')
    this.headerInHtml.querySelector('.octicon-arrow-down').classList.add('hide')
  } 
}
