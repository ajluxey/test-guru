import FormInline from "./form_inline"

document.addEventListener('turbolinks:load', () => {
  const forms = document.querySelectorAll('.form-inline')
  forms.forEach((form) => new FormInline(form))
})
