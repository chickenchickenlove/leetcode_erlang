%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. 12월 2023 오후 10:37
%%%-------------------------------------------------------------------
-module(lc234).

%% API
-export([]).

-record(list_node, {val = 0 :: integer(),
                     next = null :: 'null' | #list_node{}}).

-spec is_palindrome(Head :: #list_node{} | null) -> boolean().
is_palindrome(Head) ->
  MyList = get_list_from_node(Head, []),
  ReversedList = lists:reverse(MyList),
  judge(MyList, ReversedList).

judge([], []) ->
  true;
judge([H|T], [RH|RT]) when H =/= RH ->
  false;
judge([H|T], [RH|RT]) ->
  judge(T, RT).

get_list_from_node(#list_node{val=Value, next=null}, Acc) ->
  [Value|Acc];
get_list_from_node(Node = #list_node{val=Value, next=Next}, Acc) ->
  get_list_from_node(Next, [Value|Acc]).