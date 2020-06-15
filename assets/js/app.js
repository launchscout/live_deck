import "phoenix_html"

import { Socket } from "phoenix"
import LiveSocket from "phoenix_live_view"
import Prism from 'prismjs';
import Hooks from './hooks/hooks'

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks
});
liveSocket.connect()

setInterval((() => Prism.highlightAll()), 50)
