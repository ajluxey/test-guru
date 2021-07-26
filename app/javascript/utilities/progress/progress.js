document.addEventListener('turbolinks:load', () => {
  let progressBar = document.querySelector('.progress')
  new ProgressBar(progressBar)
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
    this.currentProgress = parseInt(currentProgress.innerHTML)
    this.fullProgress = parseInt(fullProgress.innerHTML)
  }

  calculateAndShowProgress () {
    this.progress.style.width = this.currentProgress / this.fullProgress * 100 + "%" 
  }
}