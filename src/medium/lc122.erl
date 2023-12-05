%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%%-------------------------------------------------------------------
-module(lc122).

%% API
-export([max_profit/1]).
-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
  P_Tuple = list_to_tuple(Prices),
  case length(Prices) of
    1 -> 0;
    _ -> solution(length(Prices), P_Tuple)
  end.

solution(1, _) ->
  0;
solution(Index, P_Tuple) ->
  PreviousValue = solution(Index-1, P_Tuple),
  Diff = element(Index, P_Tuple) - element(Index-1, P_Tuple),
  StartDiff = element(Index, P_Tuple) - element(1, P_Tuple),
  M1 = max(PreviousValue + Diff, PreviousValue),
  max(M1, StartDiff).












