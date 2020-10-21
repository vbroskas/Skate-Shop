defmodule SkateShop.Scraper do
  @source_url "https://usa.shop-task.com/collections/inline-skates-2"
  def get_all_skates do
    skate_data =
      get_page_body(@source_url)
      |> get_skate_links_from_page()
      |> Task.async_stream(
        fn url -> get_skate_details(url) end,
        max_concurrency: 5,
        timeout: 10_000
      )
      |> Enum.reduce([], fn {:ok, skate_details}, acc ->
        [skate_details | acc]
      end)
      |> IO.inspect()
  end

  defp get_skate_links_from_page(page_source) do
    page_source
    |> parse_document()
    |> Floki.find("a.more-info")
    |> Enum.reduce([], fn x, acc -> [Floki.attribute(x, "href") | acc] end)
    |> List.flatten()
    |> Enum.map(fn url ->
      %URI{
        path: url,
        host: "usa.shop-task.com",
        scheme: "https"
      }
      |> URI.to_string()
    end)
  end

  def get_skate_details(skate_url) do
    parsed_page =
      skate_url
      |> get_page_body()
      |> parse_document()

    %{
      model: get_model_from_skate_page(parsed_page),
      image: get_image_from_skate_page(parsed_page)
      #   description: get_description_from_skate_page(parsed_page),
      #   frame: get_frame_from_skate_page(parsed_page),
      #   price: get_price_from_skate_page(parsed_page)
    }
  end

  def get_model_from_skate_page(parsed_page) do
    parsed_page
    |> Floki.find(".layout-column-half-right .title")
    |> Floki.text(deep: false)
    |> String.trim()
  end

  def get_image_from_skate_page(parsed_page) do
    IO.puts("IN IMAGE PARSE")

    parsed_page
    |> Floki.find("a.shows-lightbox img")
    |> Floki.attribute("src")
    |> List.first()
    |> String.trim_leading("/")
  end

  defp get_page_body(url) do
    %HTTPoison.Response{body: body} = HTTPoison.get!(url)
    body
  end

  defp parse_document(page_body) do
    Floki.parse_document!(page_body)
  end
end
