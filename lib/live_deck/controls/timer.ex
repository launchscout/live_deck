defmodule LiveDeck.Controls.Timer do
  @moduledoc """
  Exposes a Timer struct and associated functions for
  working with timers.
  """
  defstruct tref: nil,
            time: ~T[00:00:00.00]

  @type t :: %__MODULE__{
          tref: :timer.tref() | nil,
          time: Time.t()
        }

  def init, do: %__MODULE__{}

  @spec start(non_neg_integer) :: t()
  def start(interval \\ 1000) do
    {:ok, tref} = :timer.send_interval(interval, :tick)

    %__MODULE__{
      tref: tref
    }
  end

  @spec stop(t()) :: t()
  def stop(timer) do
    :timer.cancel(timer.tref)

    init()
  end

  @spec tick(t()) :: t()
  def tick(timer) do
    time = Time.add(timer.time, 1)
    %__MODULE__{timer | time: time}
  end

  defimpl String.Chars, for: __MODULE__ do
    def to_string(timer) do
      to_mm_ss(timer.time)
    end

    defp to_mm_ss(time) do
      elapsed = Time.diff(time, ~T[00:00:00.00])

      mm = div(elapsed, 60)
      ss = rem(elapsed, 60) |> format_digit

      "#{mm}:#{ss}"
    end

    defp format_digit(unit) do
      case unit < 10 do
        true -> "0#{unit}"
        false -> "#{unit}"
      end
    end
  end
end
