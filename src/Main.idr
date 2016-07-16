module Main

%include C "hotp.h"
%link C "libhotp.a"
-- %link C "libhotp.dylib"

%access public export
%default total

||| Print "2 + 2 = " via Rust (via `FFI_C`).
twoPlusTwoIs : IO ()
twoPlusTwoIs = foreign FFI_C "two_plus_two_is" (IO ())

||| Add two to `x` via Rust FFI (via `FFI_C`).
||| @x an `Int` to add two to.
addTwo : (x : Int) -> IO Int
addTwo = foreign FFI_C "add_two" (Int -> IO Int)

||| Print "2 + 2 = 4\n" through the magic of Idris and Rust.
main : IO ()
main = twoPlusTwoIs *> addTwo 2 >>= printLn
