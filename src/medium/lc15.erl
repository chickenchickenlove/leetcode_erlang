%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. 10월 2023 오후 5:44
%%%-------------------------------------------------------------------
-module(lc15).

%% API
-export([test/1]).


-spec three_sum(Nums :: [integer()]) -> [[integer()]].
three_sum(Nums) ->
  test(Nums).

test(Nums) ->
  LNums = lists:sort(Nums),
  LL = list_to_tuple(LNums),
  Result = solution1(LL, 2, #{}),
  maps:keys(Result).


two_pointer2(LIdx, MidIdx, RIdx, _, Acc) when LIdx == MidIdx orelse RIdx == MidIdx ->
  Acc;
two_pointer2(LIdx, MidIdx, RIdx, Nums, Acc) ->
%%  io:format("LIdx ~p, MidIDx ~p, RIdx ~p ~n", [LIdx, MidIdx, RIdx]),
  L = element(LIdx, Nums),
  M = element(MidIdx, Nums),
  R = element(RIdx, Nums),

  Sum = L + M + R,
  if
    Sum == 0 -> two_pointer2(LIdx + 1,MidIdx, RIdx, Nums, Acc#{[L,M,R] => 1});
    Sum < 0 -> two_pointer2(LIdx + 1, MidIdx, RIdx, Nums, Acc);
    true -> two_pointer2(LIdx, MidIdx, RIdx-1, Nums, Acc)
  end.

solution1(Nums, MidIndex, Acc) when MidIndex == tuple_size(Nums) ->
  Acc;
solution1(Nums, MidIndex, Acc) ->
  Len = tuple_size(Nums),
  Position =
    if
      (Len rem 2) == 1 -> MidIndex ;
      true -> MidIndex
    end,

  Result = two_pointer2(1, Position, Len, Nums, Acc),
  if
    Result == [] -> solution1(Nums, Position + 1, Acc);
    true ->
      solution1(Nums, Position + 1, maps:merge(Result, Acc))
  end.