defmodule Scrivener.Elastic.Post do
  @es_index "posts"
  @es_type "post"
  use Elastic.Document.API
  use Scrivener, page_size: 5, max_page_size: 10

  defstruct [:title, :body, :published, :id]

end
