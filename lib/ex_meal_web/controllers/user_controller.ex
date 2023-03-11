defmodule ExMealWeb.UserController do
  use ExMealWeb, :controller

  alias ExMeal.Users.User

  action_fallback ExMealWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- ExMeal.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- ExMeal.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- ExMeal.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, %User{} = user} <- ExMeal.update_user(id, params) do
      conn
      |> put_status(:ok)
      |> render("update.json", user: user)
    end
  end
end
