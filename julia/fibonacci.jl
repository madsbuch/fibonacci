function naive_exp(base, exp)
  result = base
  for i in 1:exp-1
    result *= base
  end
  return result
end

function fast_exp(base, exp)
  result = 1
  while exp > 0
    if exp % 2 == 0
      # Wen the exponent is even we exploit the power of a power rule
      # and set the new base to base^2
      base *= base
      exp = exp ÷ 2
    end
  
    result *= base
    exp -= 1
  
  end
  return result
end

function fib(n) 
  Q = [big(1) big(1);big(1) big(0)]
  return fast_exp(Q, n)[1, 2]
end
