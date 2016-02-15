defmodule AskGary.ChannelController do
  use AskGary.Web, :controller
  plug :scrub_params, "channel" when action in [:create]

  alias AskGary.Channel

  def index(conn, _params) do
    channels = Repo.all(Channel)
    render conn, "index.html", channels: channels
  end

  def show(conn, %{"id" => id}) do
    channel = Repo.get(Channel, id)
    render conn, "show.html", channel: channel
  end

  def new(conn, _params) do
    changeset = Channel.changeset(%Channel{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"channel" => channel_params}) do
    changeset = Channel.changeset(%Channel{}, channel_params)
    case Repo.insert(changeset) do
    {:ok, channel} ->
      conn
      |> put_flash(:info, "#{channel.name} created!")
      |> redirect(to: channel_path(conn, :show, channel.id))
    {:error, changeset} ->
      render(conn, "new.html", changeset: changeset)
    end
  end
end
