export const PresenterModeHook = {
  mounted() {
    this.pushWidth();
    window.addEventListener("resize", () => {
      this.pushWidth()
    })
  },
  pushWidth() {
    this.pushEvent("resize", {
      width: window.innerWidth
    })
  }
}
