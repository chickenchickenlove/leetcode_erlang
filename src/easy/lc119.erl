%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. 10월 2023 오후 1:56
%%%-------------------------------------------------------------------
-module(lc119).

%% API
-export([get_row/1]).

-spec get_row(RowIndex :: integer()) -> [integer()].
get_row(RowIndex) ->
  gen1(RowIndex + 1).

gen1(NumRows) ->
  generate2(NumRows, [1], 1).

generate2(NumRows, Carry, Count) when NumRows > Count ->
  generate2(NumRows, gen(Carry, [1], 1), Count+1);
generate2(_, Carry, _) ->
  Carry.

gen([N0|T], Acc, Count) when length([N0|T]) >= 2 ->
  [N1|_] = T,
  gen(T, [N0 + N1|Acc], Count+1);
gen(_N, Acc, _) ->
  [1|Acc].

