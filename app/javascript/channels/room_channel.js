import consumer from "./consumer";

document.addEventListener("turbolinks:load", () => {
  const controller_element = document.getElementById("controller");
  const action_element = document.getElementById("action");

  const controller = controller_element.getAttribute("data-controller");
  const action = action_element.getAttribute("data-action");

  if (controller == "ExchangeRequestsController" && action == "show") {
    const room_element = document.getElementById("room_id");
    const room_id = room_element.getAttribute("data-exchange-id");

    consumer.subscriptions.create(
      { channel: "RoomChannel", room_id: room_id },
      {
        connected() {
          console.log("connection to exchange with " + room_id + " id");
        },

        disconnected() {
          // Called when the subscription has been terminated by the server
        },

        received(data) {
          const user_element = document.getElementById("user-id");
          const user_id = user_element.getAttribute("data-user-id");

          let html;

          if (user_id == data.message.profile_id) {
            html = data.my;
          } else {
            html = data.theits;
          }

          const chat_body = document.getElementById("chat");
          chat_body.innerHTML = chat_body.innerHTML + html;
        },
      }
    );
  }
});
