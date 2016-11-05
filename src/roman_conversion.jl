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

const NUMERAL_MAP = [
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

function parseroman(str::String)
    m = match(VALID_ROMAN_PATTERN, str)
    m == nothing && throw(InvalidRomanError(str))
    # Strip whitespace
    str = m.captures[1]
    # Make `str` uppercase
    if !isupper(str); str = uppercase(str); end
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
    val
end

function toroman(val::Integer)
    val <= 0 && throw(DomainError())
    val > 5000 && warn("Roman numerals do not handle large numbers well")

    str = ""
    for (num_val, numeral) in NUMERAL_MAP
        i = div(val, num_val)
        # Never concatenate an empty string to `str`
        i == 0 && continue
        str *= (numeral^i)
        val -= i*num_val
        # Stop when ready
        val == 0 && break
    end
    str
end
