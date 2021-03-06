document.addEventListener('turbolinks:load', () => {
  const progressBar = document.querySelector('.progress')
  if (progressBar) new ProgressBar(progressBar)
})


class ProgressBar {
  constructor (progressBar) {
    this.progressBar = progressBar
    this.testPassageId = this.progressBar.dataset.testPassageId
    this.progress = this.progressBar.querySelector(`.progress-bar[data-test-passage-id="${this.testPassageId}"`)
    this.findParametrs()
    this.calculateAndShowProgress()
  }

  findParametrs () {
    const currentProgress = document.querySelector(`.current-progress[data-test-passage-id="${this.testPassageId}"]`)
    const fullProgress = document.querySelector(`.full-progress[data-test-passage-id="${this.testPassageId}"]`)
    this.currentProgress = parseInt(currentProgress.innerHTML) - 1
    this.fullProgress = parseInt(fullProgress.innerHTML)
  }

  calculateAndShowProgress () {
    this.progress.style.width = this.currentProgress / this.fullProgress * 100 + "%" 
  }
}