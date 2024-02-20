%%%-------------------------------------------------------------------
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. 1월 2024 오후 11:32
%%%-------------------------------------------------------------------
-module(lc72).

%% API
-export([min_distance/2]).

-spec min_distance(Word1 :: unicode:unicode_binary(), Word2 :: unicode:unicode_binary()) -> integer().
min_distance(Word1, Word2) ->
  W1 = length(binary_to_list(Word1)),
  W2 = length(binary_to_list(Word2)),

  F = fun({Index, Value}, Acc) ->
    maps:put(Index, Value, Acc) end,

  MapW1 = lists:foldl(F, #{}, lists:enumerate(binary_to_list(Word1))),
  MapW2 = lists:foldl(F, #{}, lists:enumerate(binary_to_list(Word2))),
  D = #{K => none || K <- lists:seq(1, W2)},
  DP = #{K => D || K <- lists:seq(1, W1)},
  {Result, _} = sol(MapW1, MapW2, DP),
  Result.


sol(MapW1, MapW2, Dp) ->
  sol(MapW1, MapW2, maps:size(MapW1), maps:size(MapW2), Dp).
sol(_, _, I1, I2, DP) when I1 == 0; I2 == 0->
  {abs(I2-I1), DP};
sol(W1, W2, I1, I2, DP) ->
  {NewT1, NewDP} = case validate(I1, I2, W1, W2, DP) of
                     {none, true}  -> sol(W1, W2, I1-1, I2-1, DP);
                     {none, false} -> handle_diff_case(W1, W2, I1, I2, DP);
                     {V, _} -> {V, DP}
                   end,
  UpdatedDp = update(I1, I2, NewT1, NewDP),
  {NewT1, UpdatedDp}.


handle_diff_case(W1, W2, I1, I2, DP) ->
  {T1, NewDp1} = sol(W1, W2, I1, I2-1, DP),
  {T2, NewDp2} = sol(W1, W2, I1-1, I2, NewDp1),
  {T3, NewDP3} = sol(W1, W2, I1-1, I2-1, NewDp2),
  NewT = lists:min([T1, T2, T3]) + 1,
  {NewT, NewDP3}.


get(I, J, Map) ->
  maps:get(J, maps:get(I, Map)).

update(I, J, Value, Map) ->
  Row = maps:get(I, Map),
  NewRow = maps:update(J, Value, Row),
  maps:update(I, NewRow, Map).

validate(I1, I2, W1, W2, DP) ->
  First = get(I1, I2, DP),
  Second = maps:get(I1, W1) =:= maps:get(I2, W2),
  {First, Second}.
