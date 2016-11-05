using RomanNumerals
using Base.Test

# Constructor tests
@test RomanNumeral(46) == RomanNumeral("XLVI")
@test RomanNumeral(1999) == RomanNumeral("MCMXCIX")
@test rn"XXXX" == rn"XL"
@test RomanNumeral(1) == rn"I"
@test rn"xx" == rn"XX"

# Invalid numeral tests
@test_throws InvalidRomanError RomanNumeral("nope")
@test_throws InvalidRomanError RomanNumeral("XLX")

# arithmetic tests
@test rn"I" + rn"IX" == rn"X"
@test rn"L" - RomanNumeral(1) == rn"XLIX"
@test rn"X" > rn"IX"
@test isqrt(rn"MXXIV") == rn"XXXII"
@test rn"XX" ^ rn"II" == rn"CD"

# primus numeri et factorii (quis scit?)
@test factor(rn"XX")[rn"V"]    == rn"I"
@test length(primes(rn"XXIX")) == rn"X"
