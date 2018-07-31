#[macro_use] extern crate rustler;
#[macro_use] extern crate rustler_codegen;
#[macro_use] extern crate lazy_static;
extern crate brotli;

use rustler::{Env, NifResult, Term, Encoder, Error};
use rustler::types::OwnedBinary;
use rustler::resource::ResourceArc;
use brotli::{CompressorReader as BrotliCompressor, Decompressor as BrotliDecompressor};
use std::io::{Read, Write};

mod atoms {
    rustler_atoms! {
        atom ok;
        atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler_export_nifs! {
    "Elixir.Brotlex",
    [("compress", 2, compress), ("decompress", 1, decompress)],
    None
}

#[derive(NifStruct)]
#[module = "Brotlex.Native.BrotlexOptions"]
struct BrotlexOptions {
    pub compression_level: u32,
    pub lg_window_size: u32,
}


fn compress<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
  let payload: String = args[0].decode()?;
  let brotlex_options: BrotlexOptions = args[1].decode()?;
  let mut compressor = BrotliCompressor::new(payload.as_bytes(), 4096, brotlex_options.compression_level, brotlex_options.lg_window_size);
  let mut compress_bytes = Vec::new();
  match compressor.read_to_end(&mut compress_bytes) {
    Ok(_) => {
        let mut binary = OwnedBinary::new(compress_bytes.len()).unwrap();
        let _ = binary.as_mut_slice().write_all(&compress_bytes);
        Ok((atoms::ok(), binary.release(env)).encode(env))
    },
    Err(err) => Ok((atoms::error(), "error compressing payload").encode(env))
  }
}

