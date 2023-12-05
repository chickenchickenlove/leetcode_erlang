-module(lc123).

%% API
-export([max_profit/1]).
-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
  RL = lists:reverse(sol_left(Prices, 999999999, 0 ,[])),
  RR = sol_right(lists:reverse(Prices), 0, 0, []),

  NextL = [0|RL],
  NextR = RR ++ [0],
  lists:max([L + R || {L, R} <- lists:zip(NextL, NextR)]).

sol_left([], _MinValue, _MaxValue, Acc) ->
  Acc;
sol_left([H|T], MinValue, MaxValue, Acc) ->
  NextMinValue = min(H, MinValue),
  NextMaxValue = max(MaxValue, H - NextMinValue),
  sol_left(T, NextMinValue, NextMaxValue, [NextMaxValue|Acc]).

sol_right([], _Ma, _Mv, Acc) ->
  Acc;
sol_right([H|T], Ma, Mv, Acc) ->
  NextMa = max(H, Ma),
  NextMv = max(Mv, NextMa - H),
  sol_right(T, NextMa, NextMv, [NextMv|Acc]).




