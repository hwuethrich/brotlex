defmodule Brotlex.Native do
  @moduledoc false
  require Logger

  mix_config = Mix.Project.config()
  version = mix_config[:version]
  github_url = mix_config[:package][:links]["GitHub"]

  env_config = Application.get_env(:brotlex, Brotlex, [])
  force_build = System.get_env("BROTLEX_BUILD") in ["1", "true"] or env_config[:build_from_source]

  # This module will be replaced by the NIF module after
  # loaded. It throws an error in case the NIF can't be loaded.
  use RustlerPrecompiled,
    otp_app: :brotlex,
    crate: "brotlex_nif",
    mode: :release,
    base_url: "#{github_url}/releases/download/v#{version}",
    force_build: force_build,
    version: version

  def decompress(_), do: err()
  def compress(_, _), do: err()

  defp err, do: :erlang.nif_error(:nif_not_loaded)
end
