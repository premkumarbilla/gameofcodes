-module(hw).

%%API

-export([helloworld/0, helloworld/1, helloworld/2]).

helloworld() ->
  "Hello World".

helloworld(X) ->
  "Hello" ++ X.

 helloworld(X,Y)->
    "How " ++X ++ " "++ Y.