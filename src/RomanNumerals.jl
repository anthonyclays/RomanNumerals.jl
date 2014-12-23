module RomanNumerals

# Defines the exception InvalidRomanError and the immutable type RomanNumeral
include("types.jl")

# Defines the functions toroman and fromroman, to convert from Roman-formatted
# string to int and vice versa
include("conversion.jl")

# Defines new method dispatching specific to Roman numerals
include("arithmetic.jl")

export RomanNumeral

end # module RomanNumerals
