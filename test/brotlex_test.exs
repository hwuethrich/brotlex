defmodule BrotlexTest do
  use ExUnit.Case, async: true
  use ExUnitProperties
  doctest Brotlex

  describe "compress and decompress" do
    property "can decompress what is compressed" do
      check all to_compress <- binary(), max_runs: 5_000 do
        {:ok, compressed} = Brotlex.compress(to_compress, %Brotlex.Native.BrotlexOptions{})
        {:ok, decompressed} = Brotlex.decompress(compressed)
        assert decompressed == to_compress
      end
    end
  end
end
