%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. 10월 2023 오후 11:30
%%%-------------------------------------------------------------------
-module(lc136).

%% API
-export([]).
-spec single_number(Nums :: [integer()]) -> integer().
single_number(Nums) ->
  maps:fold(
    fun(Key, Value, Acc) ->
      if
        Value == 1 -> Key;
        true -> Acc
      end
    end, 0, get_maps(Nums)).

get_maps(Nums) ->
  MyFunc = fun(X, Acc) ->
    Value = maps:get(X, Acc, 0),
    Acc#{X => Value + 1} end,

  lists:foldl(MyFunc, #{}, Nums).