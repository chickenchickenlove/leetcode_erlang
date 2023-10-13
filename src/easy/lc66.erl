%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. 10월 2023 오후 11:36
%%%-------------------------------------------------------------------
-module(lc66).

%% API
-export([recursive/3]).
-spec plus_one(Digits :: [integer()]) -> [integer()].
plus_one(Digits) ->
  ReversedNumber = lists:reverse(Digits),
  recursive(ReversedNumber, [], 1).

recursive([], Acc, Carry) ->
  if
    Carry > 0 -> [Carry | Acc];
    true -> Acc
  end;
recursive([H|T], Acc, Carry) ->
  R = H + Carry,
  if
    R < 10 -> recursive(T, [R | Acc], 0);
    true -> recursive(T, [R-10 | Acc], 1)
  end.