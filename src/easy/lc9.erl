%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. 10월 2023 오후 10:00
%%%-------------------------------------------------------------------
-module(lc9).

%% API
-export([is_palindrome/1]).



-spec is_palindrome(X :: integer()) -> boolean().
is_palindrome(X) ->
  judge1(X).

judge1(X) when X < 0 ->
  false;
judge1(X) ->
  X2 = X + list_to_integer(lists:reverse(integer_to_list(X))),
  X == X2 / 2.
