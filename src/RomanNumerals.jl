module RomanNumerals

export RomanNumeral

import Base: showerror, show, length, ==

# Thrown when the string passed to `parseroman` is not a valid Roman numeral.
type InvalidRomanError <: Exception
    str::ASCIIString
end
Base.showerror(io::IO, err::InvalidRomanError) =
    print(io, err.str, " is not a valid Roman numeral")

immutable RomanNumeral <: Integer
    val::Int
    str::ASCIIString
    RomanNumeral(str::ASCIIString) = begin
        num = parseroman(str)
        new(num, toroman(num))
    end
    RomanNumeral(int::Integer) = new(int, toroman(int))
end
print(io::IO, num::RomanNumeral) = print(io, num.str)
show(io::IO, num::RomanNumeral) = write(io, num.str)
length(num::RomanNumeral) = length(num.str)
==(n1::RomanNumeral, n2::RomanNumeral) = n1.val == n2.val
==(x::BigInt, num::RomanNumeral) = num.val == x
==(num::RomanNumeral, x::BigInt) = num.val == x
==(x::Integer, num::RomanNumeral) = num.val == x
==(num::RomanNumeral, x::Integer) = num.val == x
==(str::ASCIIString, num::RomanNumeral) = num.str == str
==(num::RomanNumeral, str::ASCIIString) = num.str == str


# Regex to validate a Roman numeral
const valid_roman_pattern =
    r"""
    ^\s*                   # Skip whitespace
    (
    M*                     # Thousands
    (C{0,9}|CD|DC{0,4}|CM) # Hundreds
    (X{0,9}|XL|LX{0,4}|XC) # Tens
    (I{0,9}|IV|VI{0,4}|IX) # Ones
    )
    \s*$                   # Skip trailing whitespace
    """ix # Be case-insensitive and verbose

const numeral_map = [
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

function parseroman(str::ASCIIString)
    if !ismatch(valid_roman_pattern, str)
        throw(InvalidRomanError(str))
    end
    i = 1
    val = 0
    strlen = length(str)
    for (num_val, numeral) in numeral_map
        numlen = length(numeral)
        while i+numlen-1 <= strlen && str[i:i+numlen-1] == numeral
            val += num_val
            i += numlen
        end
    end
    val
end

function toroman(val::Integer)
    if val < 0
        throw(DomainError())
    end
    if val > 5000
        warn("Roman numerals do not handle large numbers well")
    end
    str = ""
    for (num_val, numeral) in numeral_map
        i = div(val, num_val)
        # Never concatenate an empty string to `str`
        if i == 0; continue; end
        str *= (numeral ^ i)
        val -= i*num_val
    end
    str
end
toroman(num::RomanNumeral) = toroman(num.val)

end # module RomanNumerals
