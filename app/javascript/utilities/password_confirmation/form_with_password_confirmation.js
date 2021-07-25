import PasswordInput from "./password_input"

export class FormWithPasswordConfirmation {
  constructor (form) {
    this.form = form
    this.passwordField = null
    this.confirmationField = null

    this.parseForm()
    this.addInputListeners()
  }

  parseForm () {
    const inputs = this.form.querySelectorAll('input[type="password"]')
    const tmp = []
    inputs.forEach((inputField) => tmp.push(new PasswordInput(inputField)))
    [this.passwordField, this.confirmationField] = tmp
  }

  addInputListeners () {
    this.passwordField.inputField.addEventListener('input', this.confirmation.bind(this))
    this.confirmationField.inputField.addEventListener('input', this.confirmation.bind(this))
  }

  confirmation () {
    if (this.confirmationField.getValue()) {
      if (this.passwordField.getValue() === this.confirmationField.getValue()) {
        this.confirmationSuccessful()
      } else {
        this.confirmationFailed()
      }
    } else {
      this.withoutConfirmation()
    }
  }

  confirmationFailed () {
    this.passwordField.setRedBorder()
    this.confirmationField.setRedBorder()
  }

  confirmationSuccessful () {
    this.passwordField.setGreenBorder()
    this.confirmationField.setGreenBorder()
  }

  withoutConfirmation () {
    this.passwordField.defaultBorder()
    this.confirmationField.defaultBorder()
  }
}
