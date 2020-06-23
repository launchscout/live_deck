defmodule LiveDeckWeb.PresentationView do
  use LiveDeckWeb, :view

  def background_exists?,
    do:
      File.exists?(
        "lib/live_deck_web/templates/background/#{LiveDeck.Presentations.Config.theme()}.html.eex"
      )

  def current_date do
    {year, month, day} = elem(:calendar.local_time(), 0)
    "#{Timex.month_name(month)} #{day_suffix(day)}, #{year}"
  end

  defp day_suffix(day) when day in [2, 22], do: "#{day}nd"
  defp day_suffix(day) when day in [3, 23], do: "#{day}rd"
  defp day_suffix(day) when day in [1, 21, 31], do: "#{day}st"
  defp day_suffix(day), do: "#{day}th"
end
