# Regex to validate a Roman numeral
const VALID_ROMAN_PATTERN =
    r"""
    ^\s*                   # Skip leading whitespace
    (
    M*                     # Thousands
    (C{0,9}|CD|DC{0,4}|CM) # Hundreds
    (X{0,9}|XL|LX{0,4}|XC) # Tens
    (I{0,9}|IV|VI{0,4}|IX) # Ones
    )
    \s*$                   # Skip trailing whitespace
    """ix # Be case-insensitive and verbose

const OVERBAR_CHAR = Char(0x0305)
_place_overbar(c::AbstractChar) = string(c, OVERBAR_CHAR)
_place_overbar(s::AbstractString) = join(_place_overbar(c) for c in s)

const NUMERAL_MAP = [
    (1_000_000, _place_overbar("M"))
    (500_000, _place_overbar("D"))
    (100_000, _place_overbar("C"))
    (50_000, _place_overbar("L"))
    (10_000, _place_overbar("X"))
    (9000, _place_overbar("IX"))
    (8000, _place_overbar("VIII"))
    (7000, _place_overbar("VII"))
    (6000, _place_overbar("VI"))
    (5000, _place_overbar("V"))
    (4000, _place_overbar("IV"))
    (1000, "M")
    (900,  "CM")
    (500,  "D")
    (400,  "CD")
    (100,  "C")
    (90,   "XC")
    (50,   "L")
    (40,   "XL")
    (10,   "X")
    (9,    "IX")
    (5,    "V")
    (4,    "IV")
    (1,    "I")
]

function fromroman(str::AbstractString)
    m = match(VALID_ROMAN_PATTERN, str)
    m ≡ nothing && throw(Meta.ParseError(str * " is not a valid roman numeral"))
    # Strip whitespace and make uppercase
    str = uppercase(m.captures[1])
    i = 1
    val = 0
    strlen = length(str)
    for (num_val, numeral) in NUMERAL_MAP
        numlen = length(numeral)
        while i+numlen-1 <= strlen && str[i:i+numlen-1] == numeral
            val += num_val
            i += numlen
        end
    end
    return val
end

import Base: parse
parse(::Type{RomanNumeral}, s::AbstractString) = RomanNumeral(fromroman(s))

# using Compat: @warn
function toroman(val::Integer)
    val <= 0 && throw(DomainError(val, "in ancient Rome there were only strictly positive numbers"))
    val > maximum(first(t) for t in NUMERAL_MAP) && @warn("Roman numerals do not handle large numbers well") # instead if maximum, use NUMERAL_MAP[1][1]?

    str = IOBuffer()
    for (num_val, numeral) in NUMERAL_MAP
        i = div(val, num_val)
        # Never concatenate an empty string to `str`
        i == 0 && continue
        print(str, repeat(numeral,i))
        val -= i*num_val
        # Stop when ready
        val == 0 && break
    end
    String(take!(str))
end
