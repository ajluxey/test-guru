import FormInline from "./form_inline"

document.addEventListener('turbolinks:load', () => {
  let forms = document.querySelectorAll('.form-inline')
  forms.forEach((form) => new FormInline(form))
})
