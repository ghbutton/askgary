defmodule AskGary.PageController do
  use AskGary.Web, :controller

  def index(conn, _params) do
    if conn.assigns.current_user do
      redirect conn, to: "/channels"
    else
      render conn, "index.html"
    end
  end

  def redirect(conn, _params) do
    conn
      |> Phoenix.Controller.redirect(external: "http://10.230.11.193:4000/")
      |> halt
  end
end
