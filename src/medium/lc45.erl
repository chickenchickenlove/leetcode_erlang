%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. 10월 2023 오후 11:21
%%%-------------------------------------------------------------------
-module(lc45).

%% API
-export([]).


-spec jump(Nums :: [integer()]) -> integer().
-define(INF, 9999).

jump(Nums) ->
  test(Nums).


test(Nums) ->
  TotalLen = length(Nums),
%%  MyMaps = get_dict(#{}, TotalLen),
  MyMaps = initialize_map(TotalLen),
  ResultMaps = iter(Nums, MyMaps, 1, TotalLen),
  maps:get(TotalLen, ResultMaps).

iter([], MyMaps, _, _) ->
  MyMaps;
iter([H|T], MyMaps, Now, Limit) ->
  UpdatedMaps = add_func(MyMaps, H, Limit, Now),
  iter(T, UpdatedMaps, Now + 1, Limit).

add_func(Maps, 0, _, _ )->
  Maps;
add_func(Maps, Jump, Limit, Now) when Jump + Now > Limit->
  add_func(Maps, Jump-1, Limit, Now);
add_func(Maps, Jump, Limit, Now) when Jump + Now =< Limit->
  Next = Now + Jump,
  PreviousValue = maps:get(Next, Maps),
  NowValue = maps:get(Now, Maps),
  if
    PreviousValue > NowValue -> add_func(Maps#{Next => NowValue + 1}, Jump-1, Limit, Now);
    true -> add_func(Maps, Jump-1, Limit, Now)
  end.

get_dict(Acc, 0) ->
  Acc#{1 => 0};
get_dict(Acc, TotalLen)->
  get_dict(Acc#{TotalLen => ?INF}, TotalLen - 1).


initialize_map(1) ->
  #{1 => 0};
initialize_map(TotalLen) ->
  maps:put(TotalLen, ?INF, initialize_map(TotalLen - 1)).