%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. 10월 2023 오후 5:19
%%%-------------------------------------------------------------------
-module(lc18).

%% API
-export([]).

-spec four_sum(Nums :: [integer()], Target :: integer()) -> [[integer()]].
four_sum(Nums, Target) ->
  sol(Nums, Target).

sol(Nums, Target) ->
  N = lists:sort(Nums),
  SortedTargetTuple = list_to_tuple(lists:reverse(lists:sort(lists:foldl(fun(X,Acc) -> [Target-X|Acc] end, [], N)))),
  NumsTuple = list_to_tuple(N),
  Result = outer_for(SortedTargetTuple, 1, NumsTuple, []),
  Ret1 = lists:foldl(fun(X, Acc) -> Acc#{X=>1} end, #{}, Result),
%%  Ret1 = #{X => "1" || X <- Result},
  maps:keys(Ret1).




outer_for(TargetTuple, Index, _NumsTuple, Acc) when Index == tuple_size(TargetTuple) + 1->
  Acc;
outer_for(TargetTuple, Index, NumsTuple, Acc) when Index > 1 andalso element(Index, NumsTuple) == element(Index-1, NumsTuple) ->
  outer_for(TargetTuple, Index+1, NumsTuple, Acc);
outer_for(TargetTuple, Index, NumsTuple, Acc) ->
  Target = element(Index, TargetTuple),
  NextAcc = inner_for(Target, NumsTuple, Index+1, Index, Acc),
  outer_for(TargetTuple, Index + 1, NumsTuple, NextAcc).

inner_for(_Target, NumsTuple, NowIndex, _TargetIndex, Acc) when  NowIndex >= tuple_size(NumsTuple)->
  Acc;
inner_for(Target, NumsTuple, NowIndex, TargetIndex, Acc) ->
  NextAcc = left_right_for(NumsTuple, NowIndex+1, tuple_size(NumsTuple), Target, TargetIndex, NowIndex, Acc),
  inner_for(Target, NumsTuple, NowIndex+1, TargetIndex, NextAcc).


left_right_for(_, Left, Right, _, _, _, Acc) when Left >= Right ->
  Acc;
left_right_for(NumsTuple, Left, Right, Target, OuterIndex, InnerIndex, Acc) ->
  Ts = get_sum(NumsTuple, Left, Right, InnerIndex),
  Judge = judge(Left, Right, OuterIndex, InnerIndex),

  NextAcc = if
    (Ts == Target) andalso (Judge) -> [get_list(NumsTuple, Left, Right, InnerIndex, OuterIndex)|Acc];
    true -> Acc
  end,

  if
    Ts < Target -> left_right_for(NumsTuple, Left+1, Right, Target, OuterIndex, InnerIndex, NextAcc);
    true -> left_right_for(NumsTuple, Left, Right-1, Target, OuterIndex, InnerIndex, NextAcc)
  end.


judge(A,B,C,D) ->
  A=/=B andalso A=/=C andalso A=/=D andalso B=/=C andalso B=/=D andalso C=/=D.

get_sum(NumsTuple, Left, Right, InnerIndex) ->
  element(Left, NumsTuple) + element(Right, NumsTuple) + element(InnerIndex, NumsTuple).

get_list(NumsTuple, A, B, C, D) ->
  L = [element(A, NumsTuple), element(B, NumsTuple), element(C, NumsTuple), element(D, NumsTuple)],
  lists:sort(L).



