import "phoenix_html"
import { Socket } from "phoenix"
import { LiveSocket } from "phoenix_live_view"
import VegaLite from "./vegalite";

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let hooks = { VegaLite }
let liveSocket = new LiveSocket("/live", Socket, { params: { _csrf_token: csrfToken }, hooks })

liveSocket.connect()

window.liveSocket = liveSocket
