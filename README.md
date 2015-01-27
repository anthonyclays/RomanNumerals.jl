RomanNumerals.jl
================

RomanNumerals.jl is a package that brings basic support for Roman numerals to Julia.

## Usage
RomanNumerals introduces one new type called `RomanNumeral`.

You can create new Roman numerals by calling RomanNumeral("MMXV") or RomanNumeral(2015). Alternatively, you can simply write rn"MMXV" and Julia will interpret it correctly.

Basic arithmetic operations are supported.

### Examples

```julia
julia> RomanNumeral(100)
C

julia> a = rn"lvi"
LVI

julia> b = rn"XXXX"
XL

julia> a + b, a % b
(XCVI,XVI)

julia> factor(rn"XLVIII")
Dict{RomanNumeral,RomanNumeral} with 2 entries:
  II  => IV
  III => I

julia> primes(rn"X")
4-element Array{RomanNumeral,1}:
  II
 III
   V
 VII
```

## Features
- A forgiving parser:
  - Leading and trailing whitespace is ignored
  - Can handle both lowercase and uppercase (and mixes of the two)
  - Can interpret non-optimal numerals (e.g. `XIIII`).
    Non-optimal numerals were valid in traditional Rome, and even used more commonly than their minimal counterparts.
    RomanNumerals.jl will automatically optimize non-optimal inputs.
- Can do number theory (Who knew the Romans were into this kind of thing)
- Fast

## Contributing
Pull requests adding functionality are welcome (but please take note of the style guidelines)
