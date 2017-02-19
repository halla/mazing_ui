
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
  }
}

export default Agent
