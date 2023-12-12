%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end

%%%-------------------------------------------------------------------
-module(lc14).


%% API
-export([longest_common_prefix/1]).

-spec longest_common_prefix(Strs :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
longest_common_prefix(Strs) ->
  B = length(Strs),
  io:format("Length ~p ~n", [B]),
  A = lists:foldl(fun(X, Acc) -> [binary_to_list(X)|Acc] end, [], Strs),
  io:format(A)
.