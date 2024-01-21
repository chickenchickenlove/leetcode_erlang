%%%-------------------------------------------------------------------
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 21. 1월 2024 오전 9:07
%%%-------------------------------------------------------------------
-module(lc120).

%% API
-export([minimum_total/1]).


-spec minimum_total(Triangle :: [[integer()]]) -> integer().
minimum_total(Triangle) ->
  N = length(Triangle),
  case N of
    1 -> lists:nth(1, lists:nth(1, Triangle));
    _ ->
      TriangleMap = build_map(Triangle),
      Result = sol(N, TriangleMap),
      lists:min(maps:values(maps:get(N, Result)))
  end.


build_map(Triangle) ->
  N = length(Triangle),
  lists:foldl(
    fun({List, I}, Acc) ->
      T = lists:zip(List, lists:seq(1, length(List))),
      SubMap = lists:foldl(fun({E, J}, A1) -> A1#{J => E} end, #{}, T),
      Acc#{I => SubMap}end
    , #{}, lists:zip(Triangle, lists:seq(1, N))).


sol(Height, TriangleMap) ->
  sol(2, Height, TriangleMap).

sol(Now, Height, TriangleMap) when Now > Height ->
  TriangleMap;
sol(Now, Height, TriangleMap) ->
  WidthLimit = maps:size(maps:get(Now, TriangleMap)),
  NewTriangleMap = sol(Now, Height, 1, WidthLimit, TriangleMap),
  sol(Now+1, Height, NewTriangleMap).


sol(_NowHeight, _HeightLimit, NowWidth, WidthLimit, TriangleMap) when NowWidth > WidthLimit ->
  TriangleMap;
sol(NowHeight, HeightLimit, NowWidth, WidthLimit, TriangleMap) ->
  NowValue = maps:get(NowWidth, maps:get(NowHeight, TriangleMap)),
  NewValue = case NowWidth of
    1 ->
      get(NowHeight-1, 1, TriangleMap) + NowValue;
    WidthLimit ->
      get(NowHeight-1, WidthLimit-1, TriangleMap) + NowValue;
    _ ->
      min(
        get(NowHeight-1, NowWidth-1, TriangleMap),
        get(NowHeight-1, NowWidth, TriangleMap)) + NowValue
             end,
  UpdatedMap = update(NowHeight, NowWidth, NewValue, TriangleMap),
  sol(NowHeight, HeightLimit, NowWidth + 1, WidthLimit, UpdatedMap).

get(I, J, Map) ->
  maps:get(J, maps:get(I, Map)).

update(I, J, V, Map) ->
  SMap = maps:get(I, Map),
  NewSMap = SMap#{J => V},
  Map#{I => NewSMap}.