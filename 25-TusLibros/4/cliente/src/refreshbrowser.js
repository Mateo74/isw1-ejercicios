var ws = new WebSocket("ws://127.0.0.1:8178/")
ws.onmessage = function (event) {
  console.log(event.data)
  window.location.reload(true)
};
