export const BackgroundClassHook = {
  mounted() {
    this.changeBackground();
  },
  updated() {
    this.changeBackground();
  },
  changeBackground() {
    const body = document.querySelector('body');
    const backgroundClass = this.el.dataset["backgroundClass"];
    body.classList.forEach((klass) => body.classList.remove(klass));
    body.classList.add(backgroundClass);
  }
}