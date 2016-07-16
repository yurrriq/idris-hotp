module Main

%include C "hotp.h"
-- %link C "libhotp.a"
%link C "libhotp.dylib"

%access public export
-- %default total

namespace Operators
  infixl 8 .:
  infixr 9 >>>

  ||| Binary function composition.
  ||| @f an "outer" unary function.
  ||| @g an "inner" binary function.
  |||
  ||| ```idris
  ||| lemma : (f .: g) x y = f (g x y)
  ||| lemma = Refl
  ||| ```
  (.:) : (f : c -> d) -> (g : a -> b -> c) -> (x : a) -> (y : b) -> d
  (.:) = (.) . (.)

  ||| Left-to-right function composition.
  (>>>) : (a -> b) -> (b -> c) -> a -> c
  (>>>) = flip (.)

newline : String -> String
newline = (++ "\n")


namespace Experiment
  ||| Print `2 + 2 = ` via Rust (via `FFI_C`).
  twoPlusTwoIs : IO ()
  twoPlusTwoIs = foreign FFI_C "two_plus_two_is" (IO ())

  ||| Add two to `x` via Rust FFI (via `FFI_C`).
  ||| @x an `Int` to add two to.
  addTwo : (x : Int) -> IO Int
  addTwo = foreign FFI_C "add_two" (Int -> IO Int)

namespace HMAC
  cons : (secret, input : String) -> String
  cons = unsafePerformIO .:
    foreign FFI_C "hmac_cons" (String -> String -> IO String)

namespace SHA256
  digest : String -> String
  digest = unsafePerformIO . foreign FFI_C "sha256_digest" (String -> IO String)

main : IO ()
main = repl "> " (digest >>> newline)
-- main = repl "> " (hmac_cons "secret" >>> newline)
-- main = digest "testing" >>= putStrLn
--      *> twoPlusTwoIs
--      *> addTwo 2 >>= printLn
