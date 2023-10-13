%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. 10월 2023 오후 11:05
%%%-------------------------------------------------------------------
-module(lc1929).

%% API
-export([get_concatenation/1]).

%% Solution1
-spec get_concatenation(Nums :: [integer()]) -> [integer()].
get_concatenation(Nums) ->
  Nums ++ Nums.

%% Solution2
get_concatenation(Nums) ->
  solv(Nums, Nums, []).

%% 재귀를 이용해서 해볼 수 있음.
solv([], [], Acc) ->
  lists:reverse(Acc);
solv(Rest, [], Acc) ->
  solv([], Rest, Acc);
solv(Hold, [H|T], Acc) ->
  solv(Hold, T, [H|Acc]).



