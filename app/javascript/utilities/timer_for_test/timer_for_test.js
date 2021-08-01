export default class TimerForTest {
  constructor (timerDiv, form) {
    this.timerInit = parseInt(timerDiv.querySelector('.time-limit').value)
    this.timer = timerDiv.querySelector('.current-time-limit')
    this.form = form

    this.show()
    this.updateTimer()
  }

  updateTimer () {
    const timerInit = this.timerInit
    let timerId = setInterval(this.show.bind(this), 1000)
    setTimeout(() => { clearInterval(timerId); this.form.submit() }, timerInit * 1000)
  }

  show () {
    if (this.timerInit) {
      this.timer.innerHTML = this.secToTime(this.timerInit)
      this.timerInit -= 1
    }
  }

  secToTime (seconds) {
    const hours = Math.floor(seconds / 60 / 60)
    seconds = seconds % (60 * 60)
    const minutes = Math.floor(seconds / 60)
    seconds = seconds % 60
    return `${hours}:${minutes}:${seconds}`
  }
}