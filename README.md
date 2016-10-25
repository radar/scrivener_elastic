# Elastic + Scrivener = :heart:

This library adds pagination capabiilties to [Elastic](https://github.com/radar/elastic).

## Installation

Add this package to your `mix.exs` `deps` definition:

```
defp deps do
  [
    {:scrivener_elastic, "~> 1.0.0"},
  ]
end
```

## Usage

Pagination happens on a per-module basis. Here's an example of a module configured to use both `Elastic.Document.API` and `Scrivener`.

```
defmodule Scrivener.Elastic.Post do
  @es_index "posts"
  @es_type "post"
  use Elastic.Document.API
  use Scrivener, page_size: 5, max_page_size: 10

  defstruct [:title, :body, :published, :id]

end
```

And here's how to do pagination:

```
alias Scrivener.Elastic.Post
...

page = Post.search_query(%{}) |> Post.paginate
```

You can get the documents from Elastic with `page.entries`.

You can pass `paginate` some options like `page_size` and `page` too:

```
page = Post.search_query(%{}) |> Post.paginate
```


