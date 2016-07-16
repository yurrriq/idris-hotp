#![crate_type = "staticlib"]
// #![crate_type = "dylib"]

extern crate libc;
// extern crate crypto;

use libc::c_int;
use std::ffi::CString;

/// Print `2 + 2 = ` via C. See also: [print](fn.print.html).
#[no_mangle]
pub unsafe extern "C" fn two_plus_two_is() {
    print("2 + 2 = ");
}

/// Add two to `x` and return the result.
#[no_mangle]
pub extern "C" fn add_two(x: c_int) -> c_int {
    x + 2
}

/// Convenient, unsafe wrapper for [`libc::printf`](../libc/fn.printf.html)
/// that takes a `&str`; like rough, C-friendly version of `print!`.
unsafe fn print(s: &str) -> c_int {
    libc::printf(CString::new(s).unwrap().as_ptr())
}
