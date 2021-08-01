import TimerForTest from "./timer_for_test"

document.addEventListener('turbolinks:load', () => {
  const timerDiv = document.querySelector('.test-timer')
  if (timerDiv) {
    const form = document.querySelector(`.timer-form[data-test-passage-id="${timerDiv.dataset.testPassageId}"]`)
    if (form) new TimerForTest(timerDiv, form)
  }
})
