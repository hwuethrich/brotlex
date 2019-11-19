#[macro_use]
extern crate rustler;
#[macro_use]
extern crate rustler_codegen;
extern crate brotli;
extern crate lazy_static;

use brotli::{CompressorReader as BrotliCompressor, Decompressor as BrotliDecompressor};
use rustler::types::{Binary, OwnedBinary};
use rustler::{Encoder, Env, NifResult, Term};
use std::io::{Read, Write};

mod atoms {
    rustler_atoms! {
        atom ok;
        atom error;
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
    let payload: Binary = args[0].decode()?;
    let brotlex_options: BrotlexOptions = args[1].decode()?;
    let mut compressor = BrotliCompressor::new(
        payload.as_slice(),
        4096,
        brotlex_options.compression_level,
        brotlex_options.lg_window_size,
    );
    let mut compress_bytes = Vec::new();
    match compressor.read_to_end(&mut compress_bytes) {
        Ok(_) => {
            let mut binary = OwnedBinary::new(compress_bytes.len()).unwrap();
            let _ = binary.as_mut_slice().write_all(&compress_bytes);
            Ok((atoms::ok(), binary.release(env)).encode(env))
        }
        Err(_err) => Ok((atoms::error(), "error compressing payload").encode(env)),
    }
}

fn decompress<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let payload: Binary = args[0].decode()?;
    let mut decompressed_bytes = Vec::new();
    let mut decompressor = BrotliDecompressor::new(payload.as_slice(), 4096);
    match decompressor.read_to_end(&mut decompressed_bytes) {
        Ok(_) => {
            let mut binary = OwnedBinary::new(decompressed_bytes.len()).unwrap();
            let _ = binary.as_mut_slice().write_all(&decompressed_bytes);
            Ok((atoms::ok(), binary.release(env)).encode(env))
        }
        Err(_err) => Ok((atoms::error(), "error decompressing payload").encode(env)),
    }
}
