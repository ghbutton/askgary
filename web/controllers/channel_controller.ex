defmodule AskGary.ChannelController do
  use AskGary.Web, :controller

  alias AskGary.Channel

  def index(conn, _params) do
    channels = Repo.all(Channel)
    render conn, "index.html", channels: channels
  end

  def show(conn, %{"id" => id}) do
    channel = Repo.get(Channel, id)
    render conn, "show.html", channel: channel
  end
end
