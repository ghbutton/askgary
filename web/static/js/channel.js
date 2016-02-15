/***
 * Excerpted from "Programming Phoenix",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material,
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose.
 * Visit http://www.pragmaticprogrammer.com/titles/phoenix for more book information.
***/

let Channel = {

  init(socket, element){ if(!element){ return }
    let channelId  = element.getAttribute("data-id")
    socket.connect()
    this.onReady(channelId, socket)
  },

  onReady(channelId, socket){
    let msgContainer = document.getElementById("msg-container")
    let msgInput     = document.getElementById("msg-input")
    let postButton   = document.getElementById("msg-submit")
    let chaChannel   = socket.channel("channels:" + channelId)

    function postData(event){
      let payload = {content: msgInput.value}
      chaChannel.push("new_message", payload)
                .receive("error", e => console.log(e) )
      msgInput.value = ""
    }

    postButton.addEventListener("click", e => {
      postData(e);
    })

    msgInput.addEventListener("keydown", function(e) {
      if (!e) { var e = window.event; }

      // Enter is pressed
      if (e.keyCode == 13) {
        e.preventDefault(); // sometimes useful;
        postData(e);
      }
    }, false);

    chaChannel.on("new_message", (resp) => {
      this.renderMessage(msgContainer, resp)
    })

    chaChannel.join()
      .receive("ok", resp => {
        this.renderMultiMessages(msgContainer, resp.messages)
      })
      .receive("error", reason => console.log("join failed", reason) )
  },

  esc(str){
    let div = document.createElement("div")
    div.appendChild(document.createTextNode(str))
    return div.innerHTML
  },

  renderMessage(msgContainer, {user, content}){
    let template = document.createElement("div")
    template.innerHTML = `
    <b>${user.username}</b>: ${content}
    `
    msgContainer.appendChild(template)
    msgContainer.scrollTop = msgContainer.scrollHeight
  },

  renderMultiMessages(msgContainer, messages) {
    for (var i = 0; i < messages.length; i++) {
        this.renderMessage(msgContainer, messages[i]);
    }
  }
}
export default Channel
