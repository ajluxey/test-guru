document.addEventListener('turbolinks:load', () => {
  let form = document.querySelector('.with-password-confirmation');
  if (form) new FormWithPasswordConfirmation(form);
});


class FormWithPasswordConfirmation {
  constructor(form) {
    this.form = form;
    this.passwordField = null;
    this.confirmationField = null;

    this.parseForm();
    this.addInputListeners();
  }

  parseForm() {
    let inputs = this.form.querySelectorAll('input[type="password"]');
    let tmp = []
    inputs.forEach((inputField) => tmp.push(new PasswordInput(inputField)));
    [this.passwordField, this.confirmationField] = tmp;
  }

  addInputListeners() {
    this.passwordField.inputField.addEventListener('input', this.confirmation.bind(this));
    this.confirmationField.inputField.addEventListener('input', this.confirmation.bind(this));
  }

  confirmation() {
    if (this.confirmationField.getValue()) {
      if (this.passwordField.getValue() === this.confirmationField.getValue()) {
        this.confirmationSuccessful();
      } else {
        this.confirmationFailed();
      }
    } else {
      this.withoutConfirmation();
    }
  }

  confirmationFailed() {
    this.passwordField.setRedBorder();
    this.confirmationField.setRedBorder();
  }

  confirmationSuccessful() {
    this.passwordField.setGreenBorder();
    this.confirmationField.setGreenBorder();
  }

  withoutConfirmation() {
    this.passwordField.defaultBorder();
    this.confirmationField.defaultBorder();
  }
}

class PasswordInput {
  constructor(inputField) {
    this.inputField = inputField
  }

  getValue() {
    return this.inputField.value
  }

  setRedBorder() {
    this.inputField.classList.remove('border-success');
    this.inputField.classList.add('border-danger');
  }

  setGreenBorder() {
    this.inputField.classList.remove('border-danger');
    this.inputField.classList.add('border-success');
  }

  defaultBorder() {
    this.inputField.classList.remove('border-danger');
    this.inputField.classList.remove('border-success');
  }
}