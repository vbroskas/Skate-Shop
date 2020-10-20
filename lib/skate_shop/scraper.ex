defmodule SkateShop.Scraper do
  def get_all_skates do
    skate_data =
      get_skate_index_page()
      |> get_skate_links_from_page()
      |> IO.inspect()
  end

  defp get_skate_index_page do
    %HTTPoison.Response{body: body} =
      HTTPoison.get!("https://www.locoskates.com/collections/mens-skates")

    body
  end

  defp get_skate_links_from_page(page_source) do
    result = Floki.parse_document!(page_source)
    IO.inspect(result)
  end
end
