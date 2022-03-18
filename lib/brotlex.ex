defmodule Brotlex do
  @moduledoc """
  Compress arbitrary payload using brotli
  """
  defmodule CompressOptions do
    defstruct quality: 5,
              lg_window_size: 22
  end

  @doc """
  Returns a compressed binary

  ## Examples

      iex> Brotlex.compress("hello world")
      {:ok, <<27, 10, 0, 0, 36, 64, 106, 144, 69, 106, 242, 156, 46>>}
  """
  def compress(payload, opts \\ %CompressOptions{}) when is_binary(payload) do
    Brotlex.Native.compress(payload, opts)
  end

  @doc """
  Decompresses compressed binaries

  ## Examples

      iex> Brotlex.decompress(<<27, 10, 0, 0, 36, 64, 106, 144, 69, 106, 242, 156, 46>>)
      {:ok, "hello world"}
  """
  def decompress(payload) when is_binary(payload) do
    Brotlex.Native.decompress(payload)
  end
end
