export class FormInline {
  constructor (formInline) {
    this.formInline = formInline
    this.testId = formInline.dataset.testId
    this.testTitle = document.querySelector(`.test-title[data-test-id="${this.testId}"]`)
    this.link = document.querySelector(`.form-inline-link[data-test-id="${testId}"]`)
    
    this.withErrorsInDocument()
    this.link.addEventListener('click', (event) => {
      event.preventDefault()
      this.editHandler()
    })
  }

  editHandler () {
    if (this.formInline.classList.contains('hide')) {
      this.testTitle.classList.add('hide')
      this.formInline.classList.remove('hide')
      this.link.innerHTML = 'Cancel'
    } else {
      this.testTitle.classList.remove('hide')
      this.formInline.classList.add('hide')
      this.link.innerHTML = 'Edit'
    }
  }

  withErrorsInDocument () {
    const errors = document.querySelector('model-instance-errors')
    if (errors) {
      this.editHandler
    }
  }
}