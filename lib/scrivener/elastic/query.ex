defimpl Scrivener.Paginater, for: Elastic.Query do
  alias Scrivener.{Config, Page}

  @moduledoc false

  @spec paginate(Elastic.Query.t, Scrivener.Config.t) :: Scrivener.Page.t
  def paginate(query, %Config{page_size: page_size, page_number: page_number, module: mod}) do
    total_entries = total_entries(query, mod)

    %Page{
      page_size: page_size,
      page_number: page_number,
      entries: entries(query, mod, page_number, page_size),
      total_entries: total_entries,
      total_pages: total_pages(total_entries, page_size)
    }
  end

  defp ceiling(float) do
    t = trunc(float)

    case float - t do
      neg when neg < 0 ->
        t
      pos when pos > 0 ->
        t + 1
      _ -> t
    end
  end

  defp entries(%Elastic.Query{body: body}, mod, page_number, page_size) do
    offset = page_size * (page_number - 1)
    body = Map.merge(body, %{
      size: page_size,
      from: offset
    })
    mod.search(body)
  end

  defp total_entries(%Elastic.Query{body: body}, mod) do
    mod.count(body)
  end

  defp total_pages(total_entries, page_size) do
    ceiling(total_entries / page_size)
  end
end
