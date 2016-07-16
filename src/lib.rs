extern crate crypto;
extern crate libc;

use crypto::digest::Digest;
use crypto::hmac::Hmac;
use crypto::mac::Mac;
use crypto::sha2::Sha256;
use libc::c_char;
use std::ffi::{CString, CStr};
// use std::thread;

#[no_mangle]
pub extern "C" fn sha256_digest(ptr: *const c_char) -> *const c_char {
    let     c_str  = unsafe { CStr::from_ptr(ptr) };
    let     slice  = c_str.to_str().unwrap();

    let mut hasher = Sha256::new();
    hasher.input_str(slice);

    CString::new(hasher.result_str()).unwrap().as_ptr()
}

#[no_mangle]
pub extern "C" fn hmac_cons(sec_ptr: *const c_char, data_ptr: *const c_char) -> *const c_char {
    let     sec_str  = unsafe { CStr::from_ptr(sec_ptr) };
    let     secret   = sec_str.to_str().unwrap().as_bytes();

    let     data_str = unsafe { CStr::from_ptr(data_ptr) };
    let     data     = data_str.to_str().unwrap().as_bytes();

    let mut hmac     = Hmac::new(Sha256::new(), secret);
    hmac.input(data);

    let     result   = hmac.result();
    CString::new(result.code()).unwrap().as_ptr()
}



use libc::c_int;

/// Print `2 + 2 = ` via C. See also: [print](fn.print.html).
#[no_mangle]
pub extern "C" fn two_plus_two_is() {
    unsafe {
        print("2 + 2 = ");
    }
}

/// Add two to `x` and return the result.
#[no_mangle]
pub extern "C" fn add_two(x: c_int) -> c_int {
    x + 2
}

/// Convenient, unsafe wrapper for [`libc::printf`](../libc/fn.printf.html)
/// that takes a `&str`; like rough, C-friendly version of `print!`.
unsafe fn print(s: &str) {
    libc::printf(CString::new(s).unwrap().as_ptr());
}
