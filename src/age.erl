-module(age).

%%API

-export([getAge/1]).

getAge(Name) ->
    Age = #{"alice" => 24, "wonder" => 26, "land" => 65},
    maps:get(Name,Age, -1).