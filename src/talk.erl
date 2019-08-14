-module(talk).

%%API


-export([alice/0,bob/2,run/0,startAlice/0,startBob/1]).

alice() ->
    receive
    {message, BobNode} ->
        io:fwrite(" Alice got a message \n"),
        BobNode ! message,
        alice();
    finished -> io:fwrite("Alice is finished")
    end.

bob(0,AliceNode)->
    AliceNode ! finished,
    io:fwrite("Bob is finished \n");
bob(N,AliceNode) ->
   AliceNode ! {message, self()},
   receive
     message -> io:fwrite(" Bob got a message \n")
   end,
   bob(N-1,AliceNode).



run()->
    register(alice,spawn(talk,alice,[])),
    register(bob,spawn(talk,bob,[3])).

startAlice()->
 register(alice,spawn(talk,alice,[])).

startBob(AliceNode)->
 spawn(talk,bob,[3,AliceNode]).



%

%===========================================
% this is using PID's ..where as below one is with registers.
%-export([alice/0,bob/2,run/0]).
%
%alice() ->
%    receive
%    {message, Pid}->
%        io:fwrite(" Alice got a message \n"),
%        Pid ! message,
%        alice();
%    finished -> io:fwrite("Alice is finished")
%    end.
%
%bob(0,Pid)->
%    Pid ! finished,
%    io:fwrite("Bob is finished \n");
%bob(N,Pid) ->
%   Pid ! {message, self()},
%   receive
%     message -> io:fwrite(" Bob got a message \n")
%   end,
%   bob(N-1,Pid).
%
%
%
%run() ->
%    Pid = spawn(talk,alice,[]),
%    spawn(talk,bob,[3, Pid]).



%==================used registers for the below messaging
%-export([alice/0,bob/1,run/0]).
%
%alice() ->
%    receive
%    message->
%        io:fwrite(" Alice got a message \n"),
%        bob ! message,
%        alice();
%    finished -> io:fwrite("Alice is finished")
%    end.
%
%bob(0)->
%    alice ! finished,
%    io:fwrite("Bob is finished \n");
%bob(N) ->
%   alice ! message,
%   receive
%     message -> io:fwrite(" Bob got a message \n")
%   end,
%   bob(N-1).
%
%
%
%run()->
%    register(alice,spawn(talk,alice,[])),
%    register(bob,spawn(talk,bob,[3])).
%
