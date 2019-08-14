-module(speak).

%%API

-export([say/2,run/0]).

say(What,0) ->
  done;
say(What, Times)->
  io:fwrite(What ++ "\n"),
  say(What, Times-1).


run()->
    spawn(speak,say,["Hi", 3]),
    spawn(speak,say,["Bye", 3]).

