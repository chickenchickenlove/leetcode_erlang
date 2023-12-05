%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(lc121).

%% API
-export([]).

-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
  solution(Prices, 9876543210, 0).

solution([], _MinValAcc, ResultAcc) ->
  ResultAcc;
solution([H|T], MinValAcc, ResultAcc) ->
  NextMinValAcc = min(MinValAcc, H),
  NextResultAcc = max(ResultAcc, H - NextMinValAcc),
  solution(T, NextMinValAcc, NextResultAcc).