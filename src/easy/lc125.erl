%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. 12월 2023 오후 11:15
%%%-------------------------------------------------------------------
-module(lc125).

%% API
-export([is_palindrome/1]).

-spec is_palindrome(S :: unicode:unicode_binary()) -> boolean().
is_palindrome(S) ->
  LowerCase = [string:to_lower(X) || X <- lists:filter(fun filter_alphanumeric/1, binary_to_list(S))],
  Reverse = lists:reverse(LowerCase),
  palindrome(LowerCase, Reverse)
.

filter_alphanumeric(X) ->
    (X >= $a andalso X =< $z) orelse
    (X >= $A andalso X =< $Z) orelse
    (X >= $0 andalso X =< $9).

palindrome([], [])->
  true;
palindrome([H|T], [Q|W]) ->
  case (H =:= Q) of
    true -> palindrome(T, W);
    false -> false
  end.