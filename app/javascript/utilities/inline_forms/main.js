import FormInline from "./form_inline"

document.addEventListener('turbolinks:load', () => {
  let forms = document.querySelectorAll('form-inline')
  forms.forEach((form) => new FormInline(form))


  // let controls = document.querySelectorAll('form-inline-link')
  // for (let i = 0; i < controls.length; i++) {
  //   controls[i].addEventListener('click', formInlineLinkHeandler)
  // }

  // let errors = document.querySelector('model-instance-errors')
  // if (errors) {
  //   let modelInstanceId = errors.dataset.modelInstanceId
  //   formInlineHeandler(modelInstanceId)
  // }
})

// export function formInlineLinkHeandler (event) {
//   event.preventDefault();
//   let testId = this.dataset.testId
//   formInlineHeandler(testId);
// }

// export function formInlineHeandler (testId) {
//   let link = document.querySelector(`.form-inline-link[data-test-id="${testId}"]`)
//   let testTitle = document.querySelector(`.test-title[data-test-id="${testId}"]`)
//   let formInline = document.querySelector(`.form-inline[data-test-id="${testId}"]`)
//   if (formInline.classList.contains('hide')) {
//     testTitle.classList.add('hide')
//     formInline.classList.remove('hide')
//     link.innerHTML = 'Cancel'
//   } else {
//     testTitle.classList.remove('hide')
//     formInline.classList.add('hide')
//     link.innerHTML = 'Edit'
//   }
// }
