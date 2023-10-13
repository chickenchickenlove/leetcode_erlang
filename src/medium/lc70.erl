%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. 10월 2023 오후 11:22
%%%-------------------------------------------------------------------
-module(lc70).

%% API
-export([]).

-spec climb_stairs(N :: integer()) -> integer().
climb_stairs(N) ->
  V = get_func(#{}, N),
  VisitCount = if
                 N >= 2 -> V#{1 => 1, 2 => 1};
                 true -> V#{1 => 1}
               end,

  calculate(N, VisitCount, 1).


calculate(Target, Acc, Target) ->
  maps:get(Target, Acc);
calculate(Target, Acc, N) when Target == N + 1 ->
  Now = maps:get(N, Acc),
  N1 = maps:get(N+1, Acc),
  calculate(Target, Acc#{N + 1 => N1 + Now}, N+1);
calculate(Target, Acc, N) ->
  Now = maps:get(N, Acc),
  N1 = maps:get(N+1, Acc),
  N2 = maps:get(N+2, Acc),
  calculate(Target, Acc#{N + 1 => N1 + Now, N+2 => N2 + Now}, N+1).



get_func(Acc, -1) ->
  Acc;
get_func(Acc, N) ->
  get_func(Acc#{N => 0}, N-1).
