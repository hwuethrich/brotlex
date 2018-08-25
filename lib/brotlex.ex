defmodule Brotlex do
  @moduledoc """
  Compress arbitrary payload using brotli
  """
  use Rustler, otp_app: :brotlex, crate: :brotlex

  defmodule Native.BrotlexOptions do
    defstruct [
      compression_level: 5,
      lg_window_size: 22
    ]
  end

  @doc """
  Returns a compressed binary

  ## Examples
  

  iex > {:ok, compressed} = Brotlex.compress("wpiouqwepuiowqeruiop")
  """
  def compress(_, _ \\ %Native.BrotlexOptions{})
  def compress(_, _), do: :erlang.nif_error(:nif_not_loaded)

  @doc """
  Decompresses compressed binaries

  ## Examples
  
  iex > {:ok, decompressed} = Brotlex.decompress(compressed)
  """
  def decompress(_), do: :erlang.nif_error(:nif_not_loaded)
end
