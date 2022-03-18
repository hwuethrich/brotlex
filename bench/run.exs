[kb] = StreamData.binary(length: 1_000) |> Enum.take(1)
[mb] = StreamData.binary(length: 1_000_000) |> Enum.take(1)

inputs = %{
  "1KB (Q0)" => {kb, 0},
  "1KB (Q5)" => {kb, 5},
  "1KB (Q11)" => {kb, 11},
  "1MB (Q0)" => {mb, 0},
  "1MB (Q5)" => {mb, 5},
  "1MB (Q11)" => {mb, 11}
}

Benchee.run(
  %{
    "brotli compress" => fn {data, q} ->
      :brotli.encode(data, %{quality: q})
    end,
    "brotlex compress" => fn {data, q} ->
      Brotlex.compress(data, %Brotlex.CompressOptions{quality: q})
    end
  },
  time: 5,
  memory_time: 2,
  inputs: inputs,
  formatters: [
    Benchee.Formatters.HTML,
    Benchee.Formatters.Console
  ]
)
