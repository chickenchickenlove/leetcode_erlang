%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 16. 10월 2023 오후 10:25
%%%-------------------------------------------------------------------
-module(lc20).


%% API
-export([test/0]).


-spec is_valid(S :: unicode:unicode_binary()) -> boolean().
is_valid(S) ->
  MyList = binary_to_list(S),
  sol(MyList, [], 1, length(MyList)).

sol([], [], _, _) ->
  true;
sol(_, _, Count, Limit) when Count == Limit +1 ->
  false;
sol([H|T], [], Count, Limit) ->
  sol(T, [H], Count+1, Limit);
sol([H|T], Acc, Count, Limit) ->
  [Ah|At] = Acc,

  if
      ([H] == ")" andalso [Ah] == "(") orelse
      ([H] == "]" andalso [Ah] == "[") orelse
      ([H] == "}" andalso [Ah] == "{") ->
        sol(T, At, Count+1, Limit);
      true ->
        sol(T, [H|Acc], Count+1, Limit)
  end.


%% 테스트 코드
test() ->
%%  S = <<"()[]{}">>,
  S = <<"(]">> ,
%%  S = <<"()[]{}">>,
  MyList = binary_to_list(S),
  io:format("MyLISt ~p~n", [MyList]),
  sol(MyList, [], 1, length(MyList)).