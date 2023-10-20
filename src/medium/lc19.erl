%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 20. 10월 2023 오후 10:56
%%%-------------------------------------------------------------------
-module(lc19).

%% API
-export([test/0, test2/0, test3/0]).


%% Definition for singly-linked list.
%%
-record(list_node, {val = 0 :: integer(),
                   next = null :: 'null' | #list_node{}}).

-spec remove_nth_from_end(Head :: #list_node{} | null, N :: integer()) -> #list_node{} | null.
remove_nth_from_end(Head, N) ->
  solution(Head,N).

solution(Head, N) ->
  Nodes = get_node_list(Head, []),
  FirstNode = lists:nth(1, Nodes),
  sol3(Nodes, FirstNode, N, length(Nodes), 0).

% 길이가 하나인 경우 -> 무조건 지움.
sol3([], _, _, Len, _) when Len == 1 ->
  null;
% 제일 앞에 있는 것을 지우는 경우.
sol3([], Now, Count, _, TC) when TC == Count ->
  Now#list_node.next;
% 일반적으로 지우는 경우.
sol3([Pre|T], Now, Count, Len, TC) when TC == Count ->
  UpdatedPre = Pre#list_node{next = Now#list_node.next},
  sol3(T, UpdatedPre, Count, Len, TC + 1);
% 끝에 다 온 경우. 즉, 일반적으로 지우고 첫번째 헤드를 반환.
sol3([], Now, _, Len, TC) when TC == Len ->
  Now;
%
sol3([Pre|T], Now, Count, Len, TC) ->
  if
    % 꼬리인 경우
    Pre#list_node.next == null -> sol3(T, Pre, Count, Len, TC+1);
    % 꼬리가 아닌 경우는 이전 노드에서 업데이트 되었을 수 있기 때문에 항상 업데이트 한다.
    true -> sol3(T, Pre#list_node{next = Now}, Count, Len, TC+1)
  end.


get_node_list(Node, Acc) when Node == null ->
  Acc;
get_node_list(ListNode, Acc) ->
  get_node_list(ListNode#list_node.next, [ListNode|Acc]).



test2() ->
  Node2 = #list_node{val = 2},
  Node1 = #list_node{val = 1, next = Node2},
  N = 2,
  solution(Node1, N).


test3() ->
  Node2 = #list_node{val = 2},
  Node1 = #list_node{val = 1, next = Node2},
  N = 1,
  solution(Node1, N).


test()->
  Node5 = #list_node{val = 5},
  Node4 = #list_node{val = 4, next = Node5},
  Node3 = #list_node{val = 3, next = Node4},
  Node2 = #list_node{val = 2, next = Node3},
  Node1 = #list_node{val = 1, next = Node2},
  Target = 2,
  solution(Node1, Target).

