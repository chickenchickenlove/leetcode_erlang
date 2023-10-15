%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 15. 10월 2023 오전 10:42
%%%-------------------------------------------------------------------
-module(lc118).

%% API
-export([generate/1]).


-spec generate(NumRows :: integer()) -> [[integer()]].
generate(NumRows) ->
  generate1(NumRows, [[1]]).

% main 함수 짠다.
generate1(NumRows, Acc) when NumRows > length(Acc) ->
  [H|_] = Acc,
  generate1(NumRows, [gen(H, [1], 1)|Acc]);
generate1(NumRows, Acc) when NumRows == length(Acc) ->
  lists:reverse(Acc).

% 가드조건이 있는 것부터 먼저 넣어줘야함. 패턴 매칭이 먼저 되는 것부터 하기 때문이다.
gen([N0|T], Acc, Count) when length([N0|T]) >= 2 ->
  [N1|_] = T,
  gen(T, [N0 + N1|Acc], Count+1);
gen(_N, Acc, _) ->
  [1|Acc].
