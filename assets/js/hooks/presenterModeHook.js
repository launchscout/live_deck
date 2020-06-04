export const PresenterModeHook = {
  mounted() {
    window.addEventListener("resize", () =>
      this.pushEvent("resize", {
        width: `${window.innerWidth}`,
      })
    )
  },
}
