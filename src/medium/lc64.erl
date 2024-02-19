%%%-------------------------------------------------------------------
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. 2월 2024 오후 10:47
%%%-------------------------------------------------------------------
-module(lc64).

%% API
-export([min_path_sum/1]).

-define(START_INDEX, 0).
-spec min_path_sum(Grid :: [[integer()]]) -> integer().
min_path_sum(Grid) ->
  LengthR = length(Grid),
  [H|_] = Grid,
  LengthL = length(H),

  ColumnFun =
    fun({Index, Value}, Acc) ->
      maps:put(Index, Value, Acc)
    end,

  GridMaps = lists:foldl(
    fun({Index, Element}, Acc) ->
        ListToMap = lists:foldl(ColumnFun, #{}, lists:enumerate(?START_INDEX, Element)),
        maps:put(Index, ListToMap, Acc)
    end,
    #{},
    lists:enumerate(?START_INDEX, Grid)),

  recursive_row(GridMaps, ?START_INDEX, LengthR, LengthL).

recursive_row(Grid, IndexR, LimitR, LimitC) when IndexR == LimitR ->
  get(Grid, LimitR-1, LimitC-1);
recursive_row(Grid, IndexR, LimitR, LimitC) ->
  NewGrid = recursive_col(Grid, IndexR, ?START_INDEX, LimitC),
  recursive_row(NewGrid, IndexR+1, LimitR, LimitC).

recursive_col(Grid, _IndexR, IndexC, LimitC) when IndexC == LimitC ->
  Grid;
recursive_col(Grid, IndexR, IndexC, LimitC) ->
  NewGrid = case {IndexR, IndexC} of
    {?START_INDEX, ?START_INDEX} -> Grid;
    _ ->
      NewV =
        case judge(IndexR, IndexC) of
          {false, _} ->
            get(Grid, IndexR, IndexC-1) + get(Grid, IndexR, IndexC);
          {_, false} ->
            get(Grid, IndexR-1, IndexC) + get(Grid, IndexR, IndexC);
          {true, true} ->
            min(get(Grid, IndexR-1, IndexC), get(Grid, IndexR, IndexC-1)) + get(Grid, IndexR, IndexC)
        end,
      put(Grid, IndexR, IndexC, NewV)
  end,
  recursive_col(NewGrid, IndexR, IndexC+1, LimitC).


judge(R, C) ->
  FlagR = -1 < R-1,
  FlagC = -1 < C-1,
  {FlagR,FlagC}.

put(Map, R, C, NewValue) ->
  Col = maps:get(R, Map),
  NewCol = maps:put(C, NewValue, Col),
  maps:put(R, NewCol, Map).

get(Map, R, C) ->
  maps:get(C, maps:get(R, Map)).