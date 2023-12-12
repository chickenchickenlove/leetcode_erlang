%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. 12월 2023 오후 10:34
%%%-------------------------------------------------------------------
-module(lc21).

%% API
-export([]).

-record(list_node, {val = 0 :: integer(),
                     next = null :: 'null' | #list_node{}}).

merge_two_lists(List1, List2) ->
  L1 = get_list(List1, []),
  L2 = get_list(List2, []),
  SortedList = lists:sort(L1 ++ L2),
  make_linked_list(SortedList).

get_list(Node, _) when Node =:= null ->
  [];
get_list(#list_node{val = Value, next = null}, Acc) ->
  [Value|Acc];
get_list(#list_node{val = Value, next = Next}, Acc) ->
  get_list(Next, [Value|Acc]).

make_linked_list([]) ->
  null;
make_linked_list([H|T]) ->
  #list_node{val=H, next=make_linked_list(T)}.