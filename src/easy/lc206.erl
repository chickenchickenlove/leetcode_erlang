%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. 12월 2023 오후 11:44
%%%-------------------------------------------------------------------
-module(lc206).

-record(list_node, {val = 0 :: integer(),
                   next = null :: 'null' | #list_node{}}).

%% API
-export([]).

-spec reverse_list(Head :: #list_node{} | null) -> #list_node{} | null.
reverse_list(Head) ->
  Values = get_value(Head, []),

  case length(Values) of
    0 -> null;
    _ ->
      [H|T] = Values,
      #list_node{val = H, next = make_node_list(T)}
  end.

get_value(Node, Acc) when Node == null ->
  Acc;
get_value(Node, Acc) ->
  get_value(Node#list_node.next, [Node#list_node.val|Acc]).

make_node_list([]) ->
  null;
make_node_list([H|T]) ->
  #list_node{val = H, next = make_node_list(T)}.
