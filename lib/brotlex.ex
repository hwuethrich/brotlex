defmodule Brotlex do
  use Rustler, otp_app: :brotlex, crate: :brotlex

  def compress(_, _), do: :erlang.nif_error(:nif_not_loaded)
end
