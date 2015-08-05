module Stripe
  class Option(T)

    def initialize
      @value = nil
    end

    def initialize(k : T)
      @value = k
    end

    def value=(v : T?)
      @value = v
    end

    def value : T?
      @value
    end

    def try
      v = @value
      if v
        yield v
      end
    end
  end
end
