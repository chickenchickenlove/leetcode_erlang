%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. 12월 2023 오후 10:36
%%%-------------------------------------------------------------------
-module(lc876).

-record(list_node, {val = 0 :: integer(),
                    next = null :: 'null' | #list_node{}}).

%% API
-spec middle_node(Head :: #list_node{} | null) -> #list_node{} | null.
middle_node(Head) ->
  NodeList = lists:reverse(traverse(Head, [])),
  ListLength = length(NodeList),
  MiddlePosition = case ListLength rem 2 of
                     1 -> round(ListLength/2);
                     _ -> round(ListLength/2)+1
                   end,
  lists:nth(MiddlePosition, NodeList).

traverse(Node = #list_node{next=null}, Acc) ->
  [Node|Acc];
traverse(Node = #list_node{next=Next}, Acc) ->
  traverse(Next, [Node|Acc]).