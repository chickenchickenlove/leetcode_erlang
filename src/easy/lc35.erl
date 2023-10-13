%%%-------------------------------------------------------------------

%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. 10월 2023 오후 10:51
%%%-------------------------------------------------------------------
-module(lc35).

%% API
-export([start/0]).
-spec search_insert(Nums :: [integer()], Target :: integer()) -> integer().

start() ->
  io:format("hello ~n").

search_insert(Nums, Target) ->
  find_function(Nums, Target, 0).

find_function([], _, Acc) ->
  Acc;
find_function([H|T], Target, Acc) ->
  if
    Target > H -> find_function(T, Target, Acc + 1);
    Target =< H -> find_function(T, Target, Acc)
  end.