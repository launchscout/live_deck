defmodule LiveDeck.Controls.Timer do
  defstruct tref: nil,
            time: ~T[00:00:00.00]

  @type t :: %__MODULE__{
          tref: :timer.tref(),
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
end
