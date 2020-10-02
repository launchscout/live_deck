defmodule LiveDeckWeb.PresentationViewTest do
  use ExUnit.Case
  alias LiveDeck.Presentations.Config
  alias LiveDeckWeb.PresentationView

  describe "current_date/1" do
    test "returns the date formatted in month_name date, year format" do
      assert PresentationView.current_date(calendar(with_date: 1)) == "July 1st, 2020"
    end

    test "suffixes 2 with nd" do
      assert PresentationView.current_date(calendar(with_date: 2)) == "July 2nd, 2020"
    end

    test "suffixes 3 with rd" do
      assert PresentationView.current_date(calendar(with_date: 3)) == "July 3rd, 2020"
    end

    test "suffixes 4 through 20 with th" do
      for date <- 4..20 do
        assert PresentationView.current_date(calendar(with_date: date)) == "July #{date}th, 2020"
      end
    end

    test "suffixes 21 with st" do
      assert PresentationView.current_date(calendar(with_date: 21)) == "July 21st, 2020"
    end

    test "suffixes 22 with nd" do
      assert PresentationView.current_date(calendar(with_date: 22)) == "July 22nd, 2020"
    end

    test "suffixes 23 with rd" do
      assert PresentationView.current_date(calendar(with_date: 23)) == "July 23rd, 2020"
    end

    test "suffixes 24 through 30 with th" do
      for date <- 24..30 do
        assert PresentationView.current_date(calendar(with_date: date)) == "July #{date}th, 2020"
      end
    end

    test "suffixes 31 with st" do
      assert PresentationView.current_date(calendar(with_date: 31)) == "July 31st, 2020"
    end
  end

  describe "background_exists?/1" do
    test "returns true if the exists_fun evaluates to true" do
      exists_fun = fn file_name ->
        String.contains?(file_name, Config.theme())
      end

      assert PresentationView.background_exists?(exists_fun)
    end

    test "returns false if exists_fun evaluates to false" do
      fun = fn _ -> false end
      refute PresentationView.background_exists?(fun)
    end
  end

  defp calendar(with_date: day_of_month) do
    fn -> {{2020, 7, day_of_month}, {}} end
  end
end
