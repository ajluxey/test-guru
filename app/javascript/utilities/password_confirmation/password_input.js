export class PasswordInput {
  constructor (inputField) {
    this.inputField = inputField
  }

  getValue () {
    return this.inputField.value
  }

  setRedBorder () {
    this.inputField.classList.remove('border-success')
    this.inputField.classList.add('border-danger')
  }

  setGreenBorder () {
    this.inputField.classList.remove('border-danger')
    this.inputField.classList.add('border-success')
  }

  defaultBorder () {
    this.inputField.classList.remove('border-danger')
    this.inputField.classList.remove('border-success')
  }
}
