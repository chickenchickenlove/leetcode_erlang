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
  io:format("Word1: ~p, Word2: ~p ~n", [Word1, Word2]),
  W1 = length(binary_to_list(Word1)),
  W2 = length(binary_to_list(Word2)),

  MapW1 = #{I => S || I <- lists:seq(1, W1) , S <- binary_to_list(Word1)},
  MapW2 = #{I => S || I <- lists:seq(1, W2) , S <- binary_to_list(Word2)},
  Dp = #{I => #{J =>none || J <- lists:seq(1, W2)}  || I <- lists:seq(1, W1)},
  io:format("MapW1 ~p~n", [MapW1])

.

%%sol([], Word2, I1, I2, Dp) ->
%%  I2 - I1;
%%sol(Word1, [], I1, I2, Dp) ->
%%  I1 - I2;
%%sol(Word1, Word2, I1, I2, #{I1 := #{I2 := V}}) when V =/= none ->
%%  V;
%%sol(Word1, Word2, I1, I2, DP) ->
%%1.
%%
