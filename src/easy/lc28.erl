%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 11. 10월 2023 오후 10:32
%%%-------------------------------------------------------------------
-module(lc28).

%% API
-export([str_str/2]).
-spec str_str(Haystack :: unicode:unicode_binary(), Needle :: unicode:unicode_binary()) -> integer().

%% case of 공부.
str_str(Haystack, Needle) ->
  case binary:match(Haystack, Needle) of
    {Start, _Length} -> Start;
    nomatch -> -1
  end.