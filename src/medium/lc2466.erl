%%%-------------------------------------------------------------------

%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. 2월 2024 오전 9:12
%%%-------------------------------------------------------------------
-module(lc2466).


%% API
-export([count_good_strings/4]).


-spec count_good_strings(
    Low :: integer(),
    High :: integer(),
    Zero :: integer(),
    One :: integer()) -> integer().
count_good_strings(Low, High, Zero, One) ->
  D = round(math:pow(10, 9)) + 7,
  N = High + 1,
  Dp0 = #{Index => 0 || Index <- lists:seq(0, N-1)},

  Dp1 = maps:update(Zero, maps:get(Zero, Dp0)+1, Dp0),
  Dp2 = maps:update(One, maps:get(One, Dp1)+1, Dp1),

  Dp3 = execute(Dp2, High, Zero, One, D),
  lists:sum([maps:get(X, Dp3) || X <- lists:seq(Low, High)]) rem D.

execute(Dp, High, Zero, One, D) ->
  execute(1, Dp, High, Zero, One, D).

execute(Index, Dp, High, _, _, _) when Index == High + 1 ->
  Dp;
execute(Index, Dp, High, Zero, One, D) ->
  Dp0 = temp(Index, Zero, Dp, D),
  Dp1 = temp(Index, One, Dp0, D),
  execute(Index+1, Dp1, High, Zero, One, D).


temp(Index, Var, Dp, D) ->
  if
    Index - Var > 0 ->
      V = (maps:get(Index, Dp) + maps:get(Index - Var, Dp)) rem D,
      maps:update(Index, V, Dp);
    true -> Dp
  end.


