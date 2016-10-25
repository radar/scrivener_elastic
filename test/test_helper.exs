defmodule Scrivener.Elastic.TestCase do
  use ExUnit.CaseTemplate

  setup do
    Elastic.Index.delete("posts")
    :ok
  end
end


ExUnit.start()
