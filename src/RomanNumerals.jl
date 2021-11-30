module RomanNumerals

# Defines the exception the struct RomanNumeral
include("types.jl")

# Defines the functions toroman, fromroman and parse(RomanNumeral, x), to
# convert from Roman-formatted string to int and vice versa
include("parsing.jl")

# Defines new method dispatching specific to Roman numerals
include("arithmetic.jl")

export RomanNumeral, @rn_str

end # module RomanNumerals
