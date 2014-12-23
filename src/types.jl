import Base: showerror, convert, print, show, length, string

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

typealias RN RomanNumeral

# Standard functions
Base.convert(::Type{Int}, num::RN) = num.val
Base.print(io::IO, num::RN) = print(io, num.str)
Base.show(io::IO, num::RN) = write(io, num.str)
Base.length(num::RN) = length(num.str)
Base.string(num::RN) = num.str
#Base.int(num::RN) = num.val
