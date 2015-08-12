{% for k in [:Int64, :String, :Float64, :Bool] %}
  def {{k.id}}.from(s : {{k.id}})
    s
  end
{% end %}

def String.from(v)
  v.to_s
end

def Int64.from(v : (Float64|String))
  v.to_i
end

def Int64.from(v : Bool)
  v ? 1 : 0
end

def Int64.from(x)
  raise ArgumentError.new "No conversion available from #{x} to Int64"
end

def Bool.from(i : Int64)
  i == 0 ? false : true
end

def Bool.from(s : String)
  s.match(/[tT]|[yY]/) ? true : false
end

def Bool.from(f : Float64)
  f == 0.0 ? false : true
end

def Bool.from(a : (Array(JSON::Type)|Hash(String,JSON::Type)))
  a.empty? ? false : true
end

def Bool.from(a : Nil)
  false
end

def Float64.from(i : (Int64|String))
  i.to_f
end

def Float64.from(b : Bool)
  b ? 1.0 : 0.0
end

def Float64.from(x)
  raise ArgumentError.new "No conversion available from #{x} to Float64"
end

def Hash(K,V).from(h : Hash(K,V))
  h.clone
end

def Hash(K,V).from(h : Hash(L,W))
  Hash(K,V).new.merge(h)
end

def Hash(K,V).from(n : Nil)
  n
end

def Hash(K, V).from(x)
  raise ArgumentError.new "No conversion available from #{x} to Hash"
end

def Array(T).from(a : Array(JSON::Type))
  a.map{|h| T.from(h)}
end

def Array(T).from(x)
  raise ArgumentError.new "No conversion available from #{x}"
end

def JSON::Any.from(v : JSON::Type)
  v
end


