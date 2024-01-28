%%%-------------------------------------------------------------------
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 1월 2024 오후 11:17
%%%-------------------------------------------------------------------
-module(lc152_).

%% API
-export([max_product/1]).

-spec max_product(Nums :: [integer()]) -> integer().
max_product(Nums) ->
  N = length(Nums),
  case N of
    0 -> 0;
    1 ->
      [H|_] = Nums,
      H;
    _ -> sol(0, 0, 0, Nums, 1, N)
  end.

sol(_, _, Result, _, Index, End) when Index > End ->
  Result;
sol(Max, Min, Result, [Current|T], Index, End) ->
  NewMin = lists:min([Current, Min * Current, Max * Current]),
  NewMax = lists:max([Current, Max * Current, Min * Current]),
  NewResult = max(NewMax, Result),
  sol(NewMax, NewMin, NewResult, T, Index+1, End).






