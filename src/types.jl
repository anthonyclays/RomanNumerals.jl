using Compat

@compat struct RomanNumeral <: Integer
    val::Int
    str::String
    RomanNumeral(int::Integer) = new(int, toroman(int))
    function RomanNumeral(str::AbstractString)
        num = parse(RomanNumeral, str)
        new(num, toroman(num))
    end
end

# This macro allows the rn"MMXV" syntactic sugar
macro rn_str(str)
    RomanNumeral(str)
end

const RN = RomanNumeral

# Standard functions
# Conversion + promotion
Base.Bool(::RN) = true
(::Type{T})(num::RN) where {T <: Union{Base.BitInteger,BigInt}} = T(num.val)

Base.promote_rule(::Type{RN}, ::Type{T}) where {T <: Integer} = T

# IO
Base.show(io::IO, num::RN) = write(io, num.str)
Base.length(num::RN) = length(num.str)
Base.hash(num::RN) = @compat xor(hash(num.str), hash(num.val))
