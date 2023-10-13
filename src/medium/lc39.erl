%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 10월 2023 오후 3:08
%%%-------------------------------------------------------------------
-module(lc39).

%% API
-export([test/2]).


-spec combination_sum(Candidates :: [integer()], Target :: integer()) -> [[integer()]].
combination_sum(Candidates, Target) ->
  sol(Candidates, 1, [], Target, 0, [], length(Candidates)).

test(Nums, Target) ->
  sol(Nums, 1, [], Target, 0, [], length(Nums)).


sol(Nums, Index, Carry, Target, Sum, Acc, Limit) when Target == Sum->
  io:format("Target [Carry | Acc] ~p, Carry ~p, Acc ~p ~n", [[Carry | Acc], Carry, Acc]),
  [Carry|Acc];
sol(_, _, _, Target, Sum, Acc, _) when Target < Sum ->
  Acc;
sol(_, Index, _, _, _, Acc, Limit) when Index > Limit ->
  Acc;
sol(Nums, Index, Carry, Target, Sum, Acc, Limit) ->
  Num1 = lists:nth(Index, Nums),
  Sum1 = Sum + Num1,
  FirstAcc = sol(Nums, Index, [Num1 | Carry], Target, Sum1, Acc, Limit),

  SecondAcc = sol(Nums, Index + 1, Carry, Target, Sum, Acc, Limit),
  io:format("SecondAcc ~p, FirstAcc ~p ~n", [SecondAcc, FirstAcc]),
  SecondAcc ++ FirstAcc.



%% 또 다른 풀이. 이해 필요함.
combination_sum1(Candidates, Target) ->
  SortedCandidates = lists:sort(Candidates),
  unique_combinations(SortedCandidates, Target).

unique_combinations(_, 0) ->
  [[]];
unique_combinations([], _) ->
  [];
unique_combinations([H | T], Target) when Target < 0 ->
  [];
unique_combinations([H | T], Target) ->
  %% 현재 숫자를 포함하는 경우
  WithCurrent = lists:map(fun(Comb) -> [H | Comb] end, unique_combinations([H | T], Target - H)),
  %% 현재 숫자를 포함하지 않는 경우
  WithoutCurrent = unique_combinations(T, Target),
  WithCurrent ++ WithoutCurrent.
