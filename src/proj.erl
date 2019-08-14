-module(proj).

%%API

-export([listPrice/1]).

listPrice(Currency) ->
  CarList = getCars(),
  print(CarList,Currency).


print([],Currency) ->
  true;
print([First|Rest], Currency)->
  CarMap = getMap(),
  Price = maps:get(First,CarMap,0),
  ConvertedPrice = priceConversion(Price,Currency),
  io:fwrite("Price of the car"++ First++"is " ++ integer_to_list(ConvertedPrice)++"\n"),
  print(Rest,Currency).

priceConversion(Price, Currency) ->
  case Currency of
      gbp -> round(Price*0.8);
      eur -> round(Price*0.9);
      usd -> Price
  end.

getCars()->
  ["BMW", "Lambo","Ferrari"].

getMap()->
  #{"BMW" => 150000, "Lambo" =>500000, "Ferrari" =>700000}.


