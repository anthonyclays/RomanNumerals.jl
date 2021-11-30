"""
    RomanNumeral(::Integer)
    RomanNumeral(::AbstractString)

Roman number: it contains both the standard number and its roman representation.
It behaves like standard numbers.
"""
struct RomanNumeral <: Integer
    val::Int
    str::String
    RomanNumeral(int::Integer) = new(int, toroman(int))
    function RomanNumeral(str::AbstractString)
        num = fromroman(str)
        new(num, toroman(num))
    end
end

"""rn"MMXV" syntactic sugar"""
macro rn_str(str)
    RomanNumeral(str)
end

const RN = RomanNumeral

# Standard functions
# Conversion + promotion
Base.convert(::Type{Bool}, ::RN) = true
Base.convert(::Type{T}, x::RN) where {T<:Real} = T(x.val)

Base.promote_rule(::Type{RN}, ::Type{T}) where {T <: Integer} = T

# IO
Base.show(io::IO, num::RN) = write(io, num.str)
Base.length(num::RN) = length(num.str)
Base.hash(num::RN) = xor(hash(num.str), hash(num.val))
