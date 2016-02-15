defmodule AskGary.PageController do
  use AskGary.Web, :controller

  def index(conn, _params) do
    if conn.assigns.current_user do
      redirect conn, to: "/channels"
    else
      render conn, "index.html"
    end
  end
end
