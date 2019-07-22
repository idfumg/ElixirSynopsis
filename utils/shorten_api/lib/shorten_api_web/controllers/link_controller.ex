defmodule ShortenApiWeb.LinkController do
  use ShortenApiWeb, :controller

  alias ShortenApi.Links
  alias ShortenApi.Links.Link

  action_fallback ShortenApiWeb.FallbackController

  def index(conn, _params) do
    links = Links.list_links()
    render(conn, "index.json", links: links)
  end

  def create(conn, %{"link" => link_params}) do
    link = create_new(link_params)
    conn
      |> put_status(:created)
      |> put_resp_header("location", link_path(conn, :show, link))
      |> render("show.json", link: link)
  end

  defp create_new(%{"url" => url} = link_params) do
    case Links.get_by(url: url) do
      %Link{} = link -> link
      _ -> case Links.create_link(link_params) do
             {:ok, %Link{} = link} -> link
           end
    end
  end

  def show(conn, %{"id" => id}) do
    link = Links.get_link!(id)
    render(conn, "show.json", link: link)
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    link = Links.get_link!(id)

    with {:ok, %Link{} = link} <- Links.update_link(link, link_params) do
      render(conn, "show.json", link: link)
    end
  end

  def delete(conn, %{"id" => id}) do
    link = Links.get_link!(id)
    with {:ok, %Link{}} <- Links.delete_link(link) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_and_redirect(conn, %{"id" => id}) do
    url = id
    |> Links.get_link!()
    |> Map.get(:url)
    redirect(conn, external: url)
  end
end
