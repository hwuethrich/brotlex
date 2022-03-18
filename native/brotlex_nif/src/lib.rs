use brotli::{CompressorReader as BrotliCompressor, Decompressor as BrotliDecompressor};
use rustler::types::{Binary, OwnedBinary};
use rustler::{Encoder, Env, NifResult, NifStruct, Term};
use std::io::{Read, Write};

mod atoms {
    rustler::atoms! {
        ok,
        error,
    }
}

#[derive(NifStruct)]
#[module = "Brotlex.CompressOptions"]
struct CompressOptions {
    pub quality: u32,
    pub lg_window_size: u32,
}

#[rustler::nif]
fn compress<'a>(env: Env<'a>, payload: Binary<'a>, options: CompressOptions) -> NifResult<Term<'a>> {
    let mut compressor = BrotliCompressor::new(
        payload.as_slice(),
        4096,
        options.quality,
        options.lg_window_size,
    );
    let mut compress_bytes = Vec::new();
    match compressor.read_to_end(&mut compress_bytes) {
        Ok(_) => {
            let mut binary = OwnedBinary::new(compress_bytes.len()).unwrap();
            let _ = binary.as_mut_slice().write_all(&compress_bytes);
            Ok((atoms::ok(), binary.release(env)).encode(env))
        }
        Err(_err) => Ok((atoms::error(), "error compressing payload").encode(env))
    }
}

#[rustler::nif]
fn decompress<'a>(env: Env<'a>, data: Binary<'a>) -> NifResult<Term<'a>> {
    let mut decompressed_bytes = Vec::new();
    let mut decompressor = BrotliDecompressor::new(data.as_slice(), 4096);
    match decompressor.read_to_end(&mut decompressed_bytes) {
        Ok(_) => {
            let mut binary = OwnedBinary::new(decompressed_bytes.len()).unwrap();
            let _ = binary.as_mut_slice().write_all(&decompressed_bytes);
            Ok((atoms::ok(), binary.release(env)).encode(env))
        }
        Err(_err) => Ok((atoms::error(), "error decompressing payload").encode(env))
    }
}

rustler::init!("Elixir.Brotlex.Native", [compress, decompress]);

