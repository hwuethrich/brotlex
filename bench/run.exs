test_binaries = StreamData.binary(min_length: 1_000, max_length: 1_000_000) |> Enum.take(2000)


Benchee.run(%{
  "brotli compress" => fn -> Enum.map(test_binaries, fn x -> :brotli.encode(x) end) end,
  "brotlex compress" => fn -> Enum.map(test_binaries, fn x -> Brotlex.compress(x) end) end,
  "brotlex compress then decompress" => fn -> Enum.map(test_binaries, fn x -> Brotlex.compress(x) |> elem(1) |> Brotlex.decompress() end) end
})
