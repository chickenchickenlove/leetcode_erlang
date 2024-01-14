%%%-------------------------------------------------------------------
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 14. 1월 2024 오후 5:43
%%%-------------------------------------------------------------------
-module(lc53).


%% API
-export([]).

-spec max_sub_array(Nums :: [integer()]) -> integer().
max_sub_array(Nums) ->
  [Result|Tail] = Nums,
  case length(Nums) of
    1 -> Result;
    _ -> do(Result, Result, Tail)
  end
.

do(Result, _, []) ->
  Result;
do(Result, Previous, [H|T]) ->
  Now = max(Previous + H, H),
  NewResult = max(Result, Now),
  do(NewResult, Now, T).