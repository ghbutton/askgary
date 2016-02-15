# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     AskGary.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

import Ecto.Query, only: [from: 2]

alias AskGary.Repo
alias AskGary.User
alias AskGary.Channel


find_or_create_user = fn username, name, password ->
  case Repo.all(from u in User, where: u.username == ^username) do
    [] ->
      %User{}
      |> User.registration_changeset(%{username: username, name: name, password: password})
      |> Repo.insert!()
    _ ->
      IO.puts "User: #{username} already exists, skipping"
  end
end

find_or_create_channel = fn name ->
  case Repo.all(from c in Channel, where: c.name == ^name) do
    [] ->
      %Channel{}
      |> Channel.changeset(%{name: name})
      |> Repo.insert!()
    _ ->
      IO.puts "Channel: #{name} already exists, skipping"
  end
end

find_or_create_user.("gary", "Gary", "cat8fishes")
find_or_create_channel.("Ask Gary")
