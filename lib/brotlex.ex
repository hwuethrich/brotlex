defmodule Brotlex do
  use Rustler, otp_app: :brotlex, crate: :brotlex

  def compress(_, _), do: :erlang.nif_error(:nif_not_loaded)
  def decompress(_), do: :erlang.nif_error(:nif_not_loaded)
end

defmodule Brotlex.Native.BrotlexOptions do
  defstruct [
    compression_level: 5,
    lg_window_size: 22
  ]
end
