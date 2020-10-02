defmodule LiveDeckWeb.PresentationView do
  alias LiveDeck.Presentations.Config
  use LiveDeckWeb, :view

  @spec background_exists?((String.t() -> boolean())) :: boolean()
  def background_exists?(exists_fun \\ &File.exists?/1),
    do: exists_fun.("lib/live_deck_web/templates/background/#{Config.theme()}.html.eex")

  @spec current_date((() -> {{integer(), integer(), integer()}, any()})) :: String.t()
  def current_date(local_time_fun \\ &:calendar.local_time/0) do
    {year, month, day} = elem(local_time_fun.(), 0)
    "#{Timex.month_name(month)} #{day_suffix(day)}, #{year}"
  end

  defp day_suffix(day) when day in [2, 22], do: "#{day}nd"
  defp day_suffix(day) when day in [3, 23], do: "#{day}rd"
  defp day_suffix(day) when day in [1, 21, 31], do: "#{day}st"
  defp day_suffix(day), do: "#{day}th"
end
