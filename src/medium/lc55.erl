%%%-------------------------------------------------------------------
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 1월 2024 오후 6:03
%%%-------------------------------------------------------------------
-module(lc55).

%% API
-export([]).

-spec can_jump(Nums :: [integer()]) -> boolean().
can_jump(Nums) ->
  case length(Nums) of
    1 -> true;
    _ ->
      [H|T] = Nums,
      do(T, H)
  end
.

% 순서 조심. 마지막에 Carry = 0인 경우도 있으므로.
do([], _) ->
  true;
do(_, Carry) when Carry =< 0 ->
  false;
do([H|T], Carry) ->
  do(T, max(Carry-1, H)).











