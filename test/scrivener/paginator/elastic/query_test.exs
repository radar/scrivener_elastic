defmodule Scrivener.Paginator.Elastic.IndexTest do
  use Scrivener.Elastic.TestCase

  alias Scrivener.Elastic.Post

  defp create_posts do
    Enum.map(1..10, fn (i) ->
      {:ok, 201, post} = Post.index(i, %{
        title: "Title unpublished",
        body: "Body unpublished",
        published: false
      })
      post["_id"]
    end)
  end

  describe "paginate" do
    test "gets the first few results for an index" do
      create_posts
      Elastic.Index.refresh("posts")

      page = Post.search_query(%{}) |> Scrivener.Elastic.Post.paginate

      assert page.page_size == 5
      assert page.page_number == 1
      assert Enum.count(page.entries) == 5
      assert page.total_pages == 2
    end

    test "can be provided the current page and page size as a params map" do
      create_posts
      Elastic.Index.refresh("posts")

      page = Post.search_query(%{})
      |> Scrivener.Elastic.Post.paginate(%{"page_size" => 1, "page" => 2})

      assert page.page_size == 1
      assert page.page_number == 2
      assert Enum.count(page.entries) == 1
      assert page.total_pages == 10
    end
  end
end
