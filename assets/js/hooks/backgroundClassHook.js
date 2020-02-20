export const BackgroundClassHook = {
  mounted() {
    console.log('RUNNING BACKGROUND CLASS HOOK');
    const body = document.querySelector('body');
    console.log('data set: ', this.el.dataset);
    const backgroundClass = this.el.dataset["backgroundClass"];
    console.log('background class: ', backgroundClass);
    body.classList.forEach((klass) => body.classList.remove(klass));
    body.classList.add(backgroundClass);
  }
}