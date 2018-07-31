defmodule Brotlex do
  @moduledoc """
  Compress arbitrary payload using brotli
  """
  use Rustler, otp_app: :brotlex, crate: :brotlex

  @doc """
  Returns a compressed binary

  ## Examples
  

  iex > {:ok, compressed} = Brotlex.compress("wpiouqwepuiowqeruiop")
  """
  def compress(_, _), do: :erlang.nif_error(:nif_not_loaded)
end

defmodule Brotlex.Native.BrotlexOptions do
  defstruct [
    compression_level: 5,
    lg_window_size: 22
  ]
end
