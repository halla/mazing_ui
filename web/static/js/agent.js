
let Agent = {
  init(socket, element) {
    socket.connect();
    let channel = socket.channel("agent:1", {})
    channel.join()
      .receive("ok", resp => { console.log("Joined successfully", resp) })
      .receive("error", resp => { console.log("Unable to join", resp) })

    channel.on("agent_info", (resp) => {
      element.innerHTML = resp.html;
    });

    document.getElementById('move-up').addEventListener('click', (e) => {
      channel.push("move", { direction: "up" });
    });
    document.getElementById('move-down').addEventListener('click', (e) => {
      channel.push("move", { direction: "down" });
    });
    document.getElementById('move-left').addEventListener('click', (e) => {
      channel.push("move", { direction: "left" });
    });
    document.getElementById('move-right').addEventListener('click', (e) => {
      channel.push("move", { direction: "right" });
    });

  }
}

export default Agent
