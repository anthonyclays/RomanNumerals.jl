__precompile__()

module RomanNumerals

# Defines the exception the struct RomanNumeral
include("types.jl")

# Defines the functions toroman and parse(RomanNumeral, x), to convert from
# Roman-formatted string to int and vice versa
include("roman_conversion.jl")

# Defines new method dispatching specific to Roman numerals
include("arithmetic.jl")

export RomanNumeral, @rn_str

end # module RomanNumerals
