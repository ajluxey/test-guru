import SorterHeader from "./sorter_header"

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