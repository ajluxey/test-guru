import TableWithSort from './table_with_sort';

document.addEventListener('turbolinks:load', () => {
  const tables = document.querySelectorAll('table')
  tables.forEach((table) => {
    const sorterHeaders = table.querySelectorAll('.sort-by-this')
    if (sorterHeaders) new TableWithSort(table, sorterHeaders)
  })
})
