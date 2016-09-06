function show{T<:ArbFloat}(io::IO, x::T)
    if isexact(x)
      s = string(midpoint(x))
    else
      s = string(x)
    end
    print(io, s)
end
show{T<:ArbFloat}(x::T) = show(STDOUT, x)

function showsmall{T<:ArbFloat}(io::IO, x::T)
    s = stringsmall(x)
    print(io, s)
end
showsmall{T<:ArbFloat}(x::T) = showsmall(STDOUT, x)

function showcompact{T<:ArbFloat}(io::IO, x::T)
    s = stringcompact(x)
    print(io, s)
end
showcompact{T<:ArbFloat}(x::T) = showcompact(STDOUT, x)

function showmedium{T<:ArbFloat}(io::IO, x::T)
    s = stringmedium(x)
    print(io, s)
end
showmedium{T<:ArbFloat}(x::T) = showmedium(STDOUT, x)

function showlarge{T<:ArbFloat}(io::IO, x::T)
    s = stringlarge(x)
    print(io, s)
end
showlarge{T<:ArbFloat}(x::T) = showlarge(STDOUT, x)

function showall{T<:ArbFloat}(io::IO, x::T)
    s = stringall(x)
    print(io, s)
end
showall{T<:ArbFloat}(x::T) = showall(STDOUT, x)


function showallcompact{T<:ArbFloat}(io::IO, x::T)
    s = stringallcompact(x)
    print(io, s)
end
showallcompact{T<:ArbFloat}(x::T) = showallcompact(STDOUT, x)


function showsmart{T<:ArbFloat}(io::IO, x::T)
    s = smartstring(x)
    print(io, s)
end
# showsmart is not a Base show function, it needs explict version without io parameter
showsmart{T<:ArbFloat}(x::T) = showsmart(STDOUT, x)

function showmany{T<:ArbFloat,N}(io::IO, x::NTuple{N,T}, stringformer::Function)
    if N==0
       print(io,"()")
       return nothing
    elseif N==1
       print(io,string("( ",stringformer(x[1]),", )"))
       return nothing
    end

    ss = Vector{String}(N)
    for i in 1:N
      ss[i] = stringformer(x[i])
    end

    println(io,string("( ", ss[1], ","));
    for s in ss[2:end-1]
      println(io, string("  ", s, ","))
    end
    println(io,string("  ", ss[end], " )"))
end

showmany{T<:ArbFloat,N}(x::NTuple{N,T}, stringformer::Function) =
   showmany(STDOUT,x,stringformer)


function showmany{T<:ArbFloat}(io::IO, x::Vector{T}, stringformer::Function)
    n = length(x)

    if n==0
       print(io,"[]")
       return nothing
    elseif n==1
       print(io,string("[ ",stringformer(x[1])," ]"))
       return nothing
    end

    ss = Vector{String}(n)
    for i in 1:n
      ss[i] = stringformer(x[i])
    end

    println(io,string("[ ", ss[1], ","));
    for s in ss[2:end-1]
      println(io, string("  ", s, ","))
    end
    println(io,string("  ", ss[end], " ]"))
end

showmany{T<:ArbFloat}(x::Vector{T}, stringformer::Function) =
    showmany(STDOUT,x,stringformer)


show{P,N}(io::IO, x::NTuple{N,ArbFloat{P}}) = showmany(io, x, string)
showsmall{P,N}(io::IO, x::NTuple{N,ArbFloat{P}}) = showmany(io, x, stringsmall)
showcompact{P,N}(io::IO, x::NTuple{N,ArbFloat{P}}) = showmany(io, x, stringcompact)
showlarge{P,N}(io::IO, x::NTuple{N,ArbFloat{P}}) = showmany(io, x, stringlarge)
showmedium{P,N}(io::IO, x::NTuple{N,ArbFloat{P}}) = showmany(io, x, stringmedium)
showall{P,N}(io::IO, x::NTuple{N,ArbFloat{P}}) = showmany(io, x, stringall)

# showsmart is not a Base show function, it needs explict version without io parameter
showsmart{P,N}(io::IO, x::NTuple{N,ArbFloat{P}}) = showmany(io, x, smartstring)
showsmart{P,N}(x::NTuple{N,ArbFloat{P}}) = showmany(STDOUT, x, smartstring)

show{P}(io::IO, x::Vector{ArbFloat{P}}) = showmany(io, x, string)
showall{P}(io::IO, x::Vector{ArbFloat{P}}) = showmany(io, x, stringall)
showcompact{P}(io::IO, x::Vector{ArbFloat{P}}) = showmany(io, x, stringcompact)
# showsmart is not a Base show function, it needs explict version without io parameter
showsmart{P}(io::IO, x::Vector{ArbFloat{P}}) = showmany(io, x, smartstring)
showsmart{P}(x::Vector{ArbFloat{P}}) = showmany(STDOUT, x, smartstring)

show{P,N}(io::IO, x::Vararg{ArbFloat{P},N}) = showmany(io, x, string)
showall{P,N}(io::IO, x::Vararg{ArbFloat{P},N}) = showmany(io, x, stringall)
showcompact{P,N}(io::IO, x::Vararg{ArbFloat{P},N}) = showmany(io, x, stringcompact)
# showsmart is not a Base show function, it needs explict version without io parameter
showsmart{P,N}(io::IO, x::Vararg{ArbFloat{P},N}) = showmany(io, x, smartstring)
showsmart{P,N}(x::Vararg{ArbFloat{P},N}) = showmany(STDOUT, x, smartstring)

