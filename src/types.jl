# Thrown when the string passed to `parseroman` is not a valid Roman numeral.
type InvalidRomanError <: Exception
    str::ASCIIString
end
Base.showerror(io::IO, err::InvalidRomanError) =
    print(io, err.str, " is not a valid Roman numeral")

immutable RomanNumeral <: Integer
    val::Int
    str::ASCIIString

    RomanNumeral(int::Integer) = new(int, toroman(int))
    RomanNumeral(str::ASCIIString) = begin
        num = parseroman(str)
        new(num, toroman(num))
    end
end
# This macro allows the rn"MMXV" syntactic sugar
macro rn_str(str)
    RomanNumeral(str)
end

typealias RN RomanNumeral

# Standard functions
# Conversion + promotion
#Base.convert{T<:Integer}(::Type{T}, num::RN) = convert(T, num.val)
#Base.promote_rule{T<:Integer}(::Type{RN}, ::Type{T}) = RN
Base.string(num::RN) = num.str

# IO
Base.print(io::IO, num::RN) = print(io, num.str)
Base.show(io::IO, num::RN) = write(io, num.str)

Base.length(num::RN) = length(num.str)
Base.hash(num::RN) = hash(num.str) $ hash(num.val)
