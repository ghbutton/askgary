#---
# Excerpted from "Programming Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/phoenix for more book information.
#---
defmodule AskGary.ChannelChannel do
  use AskGary.Web, :channel
  alias AskGary.MessageView

  def join("channels:" <> channel_id, params, socket) do
    last_seen_id = params["last_seen_id"] || 0
    channel = Repo.get!(AskGary.Channel, channel_id)
    messages = Repo.all(
           from m in assoc(channel, :messages),
         where: m.id > ^last_seen_id,
      order_by: [asc: m.id],
         limit: 200,
       preload: [:user]
    )
    resp = %{messages: Phoenix.View.render_many(messages, MessageView,
                                                   "message.json")}

    {:ok, resp, assign(socket, :channel_id, channel.id)}
  end

  def handle_in(event, params, socket) do
    IO.puts "HIHI!! 3"
    user = Repo.get(AskGary.User, socket.assigns.user_id)
    handle_in(event, params, user, socket)
  end

  def handle_in("new_message", params, user, socket) do
    IO.puts "HIHI!! 4"
    changeset =
      user
      |> build(:messages, channel_id: socket.assigns.channel_id)
      |> AskGary.Message.changeset(params)

    case Repo.insert(changeset) do
      {:ok, mes} ->
        broadcast_message(socket, mes)
        {:reply, :ok, socket}

      {:error, changeset} ->
        {:reply, {:error, %{errors: changeset}}, socket}
    end
  end

  defp broadcast_message(socket, message) do
    message = Repo.preload(message, :user)
    rendered_mes = Phoenix.View.render(MessageView, "message.json", %{
      message: message
    })
    broadcast! socket, "new_message", rendered_mes
  end
end
