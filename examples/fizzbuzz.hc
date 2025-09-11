module example =
  let fizzbuzz = fn number max =>
    (match (number % 3, number % 5) with
      | (0, 0) => "FizzBuzz"
      | (0, _) => "Fizz"
      | (_, 0) => "Buzz"
      | (_, _) => format::integer number)
	|> std::println;
    if number < max then
      fizzbuzz (number + 1) max
    else
      ()

  do fizzbuzz 1 30
end
