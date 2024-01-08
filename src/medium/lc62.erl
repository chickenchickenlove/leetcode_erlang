%%%-------------------------------------------------------------------
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 1월 2024 오후 7:45
%%%-------------------------------------------------------------------
-module(lc62).

%% API
-export([unique_paths/2, update_certain_key/4, get_rc/3]).

%%% 1. 함수 내에서 익명함수 선언 시, Closure 적용됨. (패턴 매칭 적용됨)
%%% 2. 함수의 끝에서 재귀적으로 호출하는 것을 꼬리 재귀라고 함. 함수끼리 계속 연동해서 호출하는 것은 꼬리재귀로 처리됨.


-spec unique_paths(M :: integer(), N :: integer()) -> integer().
unique_paths(M, N) ->
  rpc:async_call()
  C = #{X => 0 || X <- lists:seq(1, M)},
  D = #{X => C || X <- lists:seq(1, N)},
  V = #{X => C || X <- lists:seq(1, N)},

  NewD = update_certain_key(1, 1, 1, D),
  NewQ = queue:in({1, 1}, queue:new()),
  bfs(N, M, NewQ, NewD, V, continue)
.

bfs(RowNum, ColNum, _, D, _, end_loop) ->
  get_rc(RowNum, ColNum, D);
bfs(RowNum, ColNum, Q, D, V, End) ->
  case queue:out(Q) of
    {{value, {Row, Col}}, NewQ} -> bfs_(RowNum, ColNum, D, V, End, {Row, Col, NewQ});
    {empty, Q} -> bfs(RowNum, ColNum, Q, D, V, end_loop)
  end.

bfs_(RowNum, ColNum, D, V, End, {Row, Col, NewQ}) ->
  case get_rc(Row, Col, V) of
    0 ->
      Fun = fun({RR, CC}, {QFun, DFun} = Acc) ->
        NextRow = Row + RR, NextCol = Col + CC,
        if
          (0 < NextRow andalso NextRow < RowNum + 1 andalso
            0 < NextCol andalso NextCol < ColNum + 1) ->
            % Update DP
            Value = get_rc(Row, Col, DFun),
            NextValue0 = get_rc(NextRow, NextCol, DFun),
            NextDFun = update_certain_key(NextRow, NextCol, Value + NextValue0, DFun),

            % Update Queue
            NextQFun = queue:in({NextRow, NextCol}, QFun),
            {NextQFun, NextDFun};
          true -> Acc
        end
      end,
      NewV = update_certain_key(Row, Col, 1, V),
      {NewQ1, NewD1} = lists:foldl(Fun, {NewQ, D}, [{0, 1}, {1, 0}]),
      bfs(RowNum, ColNum, NewQ1, NewD1, NewV, End);
    _ ->
      bfs(RowNum, ColNum, NewQ, D, V, End)
  end.


get_rc(Row, Column, Map) ->
  C0 = maps:get(Row, Map),
  maps:get(Column, C0).


update_certain_key(Row, Column, Value, Map) ->
  C0 = maps:get(Row, Map),
  C1 = maps:update(Column, Value, C0),
  maps:update(Row, C1, Map).







