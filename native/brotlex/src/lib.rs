#[macro_use] extern crate rustler;
#[macro_use] extern crate rustler_codegen;
#[macro_use] extern crate lazy_static;

use rustler::{Env, Term, NifResult, Encoder};

mod atoms {
    rustler_atoms! {
        atom ok;
        //atom error;
        //atom __true__ = "true";
        //atom __false__ = "false";
    }
}

rustler_export_nifs! {
    "Elixir.Brotlex",
    [("compress", 2, compress)],
    None
}

fn compress<'a>(env: Env<'a>, args: &[Term<'a>]) -> NifResult<Term<'a>> {
    let payload:  = try!(args[0].decode());

    Ok((atoms::ok(), num1 + num2).encode(env))
}
