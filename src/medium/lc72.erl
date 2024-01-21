%%%-------------------------------------------------------------------
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 18. 1월 2024 오후 11:32
%%%-------------------------------------------------------------------
-module(lc72).

%% API
-export([min_distance/2]).

-spec min_distance(Word1 :: unicode:unicode_binary(), Word2 :: unicode:unicode_binary()) -> integer().
min_distance(Word1, Word2) ->
  io:format("Word1: ~p, Word2: ~p ~n", [Word1, Word2]),
  W1 = length(binary_to_list(Word1)),
  W2 = length(binary_to_list(Word2)),

  MapW1 = #{I => S || I <- lists:seq(1, W1) , S <- binary_to_list(Word1)},
  MapW2 = #{I => S || I <- lists:seq(1, W2) , S <- binary_to_list(Word2)},

  lists:map(fun(I) ->
    Name = list_to_atom(integer_to_list(I)),
    ets:new(Name, [set, named_table]),
    ets:insert(Name, list_to_tuple([none || _ <- lists:seq(1, W2)]))
    end, lists:seq(1, W1)),

  tear_down(W1).

sol([], Word2, I1, I2) ->
  I2-I1;
sol(Word1, [], I1, I2) ->
  I1-I2;
sol(Word1, Word2, I1, I2) ->
  % Dp를 업데이트 하는 작업이 필요할 것 같음.
  Value = case get_(I1, I2) of
      none ->
        case maps:get(I1, Word1) == maps:get(I2, Word2)  of
            true -> sol(Word1, Word2, I1-1, I2-1);
            _ ->
              Insert = sol(Word1, Word2, I1, I2-1),
              Delete = sol(Word1, Word2, I1-1, I2),
              Replace = sol(Word1, Word2, I1-1, I2-1),
              lists:min([Insert, Delete, Replace])
        end;
      V -> V
  end,
  update(I1, I2, Value),
  Value.


update(I1, I2, Value) ->
  TableName = list_to_atom(integer_to_list(I1)),
  Table0 = ets:lookup(TableName),



  %% 이런 느낌으루다가...
%%  ets:insert(Table, {1, "apple"}),
%%  ets:insert(Table, {2, "banana"}),
%%  ets:insert(Table, {3, "cherry"}),


get_(I, J) ->
  TableName = list_to_atom(integer_to_list(I)),
  ets:lookup(TableName, J).





tear_down(W1) ->
  lists:map(fun(I) ->
    Name = list_to_atom(integer_to_list(I)),
    ets:delete(Name) end, lists:seq(1, W1)).