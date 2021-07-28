import FormWithPasswordConfirmation from './form_with_password_confirmation';

document.addEventListener('turbolinks:load', () => {
  const form = document.querySelector('.with-password-confirmation')
  if (form) new FormWithPasswordConfirmation(form)
})
