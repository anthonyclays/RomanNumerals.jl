using Compat

# Thrown when the string passed to `parseroman` is not a valid Roman numeral.
type InvalidRomanError <: Exception
    str::String
end
Base.showerror(io::IO, err::InvalidRomanError) =
    print(io, err.str, " is not a valid Roman numeral")

immutable RomanNumeral <: Integer
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
Base.convert{T<:Integer}(::Type{T}, num::RN) = convert(T, num.val)
Base.convert(::Type{RN}, num::Int) = RN(num)
Base.promote_rule{T<:Integer}(::Type{RN}, ::Type{T}) = T
Base.string(num::RN) = num.str
Base.parse(::Type{RomanNumeral}, str::String) = RomanNumeral(str)

# IO
Base.print(io::IO, num::RN) = print(io, num.str)
Base.show(io::IO, num::RN) = write(io, num.str)

Base.length(num::RN) = length(num.str)
Base.hash(num::RN) = @compat xor(hash(num.str), hash(num.val))
