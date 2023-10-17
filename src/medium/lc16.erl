%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 17. 10월 2023 오후 11:39
%%%-------------------------------------------------------------------
-module(lc16).

%% API
-export([test/2]).

-spec three_sum_closest(Nums :: [integer()], Target :: integer()) -> integer().
three_sum_closest(Nums, Target) ->
  NumsTuple = list_to_tuple(lists:sort(Nums)),
  recursive(1, tuple_size(NumsTuple), {9876543210, 9876543210}, NumsTuple, Target).


% Result -> (Diff, Value)
recursive(Count, Limit, Result, _, _) when Count > Limit ->
  element(2, Result);
recursive(Count, Limit, Result, NumsTuple, Target) ->
  io:format("Count ~p, Limit ~p, Target ~p ~n", [Count, Limit, Target]),
  R = sol(Count+1, Limit, Count, NumsTuple, Target, Result),
  recursive(Count+1, Limit, R, NumsTuple, Target).



sol(Left, Right, Position, NumsTuple, Target, Carry) when Left < Right ->
  TempSum = element(Position, NumsTuple) + element(Left, NumsTuple) + element(Right, NumsTuple),
  io:format("Left ~p Right ~p Poisition ~p NumsTuple ~p TempSum ~p ~n", [Left, Right, Position, NumsTuple, TempSum]),
  AbsDiff = abs(TempSum-Target),
  MinDiff = element(1, Carry),

  io:format("AbsDiff ~p~n", [AbsDiff]),
  NextCarry = if
                AbsDiff < MinDiff -> {AbsDiff, TempSum};
                true -> Carry
              end,

  if
    TempSum < Target -> sol(Left+1, Right, Position, NumsTuple, Target, NextCarry);
    true -> sol(Left, Right-1, Position, NumsTuple, Target, NextCarry)
  end;
sol(_, _, _, _, _, Result) ->
  Result.


test(Nums, Target) ->
  NumsTuple = list_to_tuple(lists:sort(Nums)),
  recursive(1, tuple_size(NumsTuple), {9876543210, 9876543210}, NumsTuple, Target).