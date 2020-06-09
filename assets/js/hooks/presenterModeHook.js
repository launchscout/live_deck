export const PresenterModeHook = {
  mounted() {
    console.log('PresenterModeHook mounted. Pushing width initially...');
    this.pushWidth();
    window.addEventListener("resize", () => {
      console.log('Resize event. Pushing width again...')
      this.pushWidth()
    })
  },
  pushWidth() {
    this.pushEvent("resize", {
      width: window.innerWidth
    })
  }
}
