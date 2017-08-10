using Compat

# Thrown when the string passed to `parseroman` is not a valid Roman numeral.
@compat mutable struct InvalidRomanError <: Exception
    str::String
end
Base.showerror(io::IO, err::InvalidRomanError) =
    print(io, err.str, " is not a valid Roman numeral")

@compat struct RomanNumeral <: Integer
    val::Int
    str::String

    RomanNumeral(int::Integer) = new(int, toroman(int))
    RomanNumeral(str::String) = begin
        num = parseroman(str)
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
Base.convert(::Type{Bool}, num::RN) = true
Base.convert(::Type{BigInt}, num::RN) = BigInt(num.val)
@compat Base.convert(::Type{T}, num::RN) where T <: Integer = convert(T, num.val)
Base.convert(::Type{RN}, num::Int) = RN(num)
@compat Base.promote_rule(::Type{RN}, ::Type{T}) where T <: Integer = T
Base.string(num::RN) = num.str

# IO
Base.print(io::IO, num::RN) = print(io, num.str)
Base.show(io::IO, num::RN) = write(io, num.str)

Base.length(num::RN) = length(num.str)
Base.hash(num::RN) = @compat xor(hash(num.str), hash(num.val))
