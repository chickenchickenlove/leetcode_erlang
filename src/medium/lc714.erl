%%%-------------------------------------------------------------------
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. 2월 2024 오전 10:04
%%%-------------------------------------------------------------------
-module(lc714).

%% API
-export([max_profit/2]).

-spec max_profit(Prices :: [integer()], Fee :: integer()) -> integer().
max_profit(Prices, Fee) ->
  N = length(Prices),
  Own = #{X => 0 || X <- lists:seq(0, N-1)},
  NotOwn = #{X => 0 || X <- lists:seq(0, N-1)},
  PricesMap = #{Index => Value || {Index, Value} <- lists:zip(lists:seq(0, N-1), Prices)},
  Own1 = Own#{0 => -maps:get(0, PricesMap) - Fee},
  execute(Own1, NotOwn, PricesMap, Fee)
.


execute(Own, NotOwn, PricesMap, Fee) ->
  execute(1, Own, NotOwn, PricesMap, Fee).

execute(Index, Own, NotOwn, PricesMap, _) when Index == map_size(PricesMap) ->
  N = map_size(PricesMap),
  max(
    maps:get(N-1, Own),
    maps:get(N-1, NotOwn)
  );
execute(Index, Own, NotOwn, PricesMap, Fee) ->
  M1 = max(
    maps:get(Index-1, Own),
    maps:get(Index-1, NotOwn) - maps:get(Index, PricesMap) - Fee
  ),
  Own0 = maps:update(Index, M1, Own),

  M2 = max(
    maps:get(Index-1, NotOwn),
    maps:get(Index-1, Own0) + maps:get(Index, PricesMap)
  ),
  NotOwn0 = maps:update(Index, M2, NotOwn),
  execute(Index+1, Own0, NotOwn0, PricesMap, Fee).
