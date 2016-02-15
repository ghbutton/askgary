#---
# Excerpted from "Programming Phoenix",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/phoenix for more book information.
#---
defmodule AskGary.MessageView do
  use AskGary.Web, :view

  def render("message.json", %{message: mes}) do
    %{
      id: mes.id,
      content: mes.content,
      user: render_one(mes.user, AskGary.UserView, "user.json")
    }
  end
end
