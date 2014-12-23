import Base: ==, isless,
    +, -, *, ^, max, min, div, %, gcd, lcm,
    isqrt, isodd, iseven, one, isprime, factor, primes

# Remember that RN is typealiased to RomanNumeral

# Equality operators
==(n1::RN, n2::RN) = n1.val == n2.val
==(x::BigInt, num::RN) = num.val == x
==(num::RN, x::BigInt) = num.val == x
==(x::Integer, num::RN) = num.val == x
==(num::RN, x::Integer) = num.val == x

# Comparisons
isless(n1::RN, n2::RN) = n1.val < n2.val
isless(num::RN, x::Integer) = num.val < x

## Arithmetic
# Multiple argument operators
for op in [:+, :-, :*, :^, :max, :min]
    @eval ($op)(ns::RN...) =
        $(op)(map(n -> n.val, ns)...) |> RN
end

# Two argument operators
for op in [:div, :%, :gcd, :lcm]
    @eval ($op)(n1::RN, n2::RN) =
        $(op)(n1.val, n2.val) |> RN
end

# One argument operators
for op in [:isqrt, :isodd, :iseven, :one, :isprime]
    @eval $(op)(num::RN) = $(op)(num.val) |> RN
end

# Who new Romans did number theory
#= TODO: Figure out dict hashing
function Base.factor(num::RN)
    factors = Dict{RN,RN}()
    for (fac, mul) in factor(num.val)
        factors[RN(fac)] = RN(mul)
    end
    factors
end
=#
Base.primes(num::RN) = map(RN, primes(num.val))
