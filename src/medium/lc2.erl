%%%-------------------------------------------------------------------
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. 1월 2024 오후 11:38
%%%-------------------------------------------------------------------
-module(lc2).

%% API
-export([]).

%% Definition for singly-linked list.
%%
-record(list_node, {val = 0 :: integer(),
                    next = null :: 'null' | #list_node{}}).

-spec add_two_numbers(L1 :: #list_node{} | null, L2 :: #list_node{} | null) -> #list_node{} | null.
add_two_numbers(L1, L2) ->
  R0 = case size_(L1, 0) > size_(L2, 0) of
    true -> add2_(L1, L2, null);
    _    -> add2_(L2, L1, null)
  end,
  reverse_(R0, null).


% 크기가 서로 다를 수 있음.
add2_(#list_node{val = V1, next = null} = _L1,
      #list_node{val = V2, next = null} = _L2,
      PreviousNode) ->
  case V1 + V2 >= 10 of
    true ->
      NowNode = #list_node{val = (V1 + V2 - 10), next = PreviousNode},
      #list_node{val = 1, next = NowNode};
    _ ->
      #list_node{val = (V1 + V2), next = PreviousNode}
  end;
add2_(#list_node{val = V1, next = N1} = _,
      #list_node{val = V2, next = null} = _,
      PreviousNode) ->
  % 필요하면 여기에 1 더하면 될 듯.
  NowNode = #list_node{val = (V1+V2), next = PreviousNode},
  case NowNode of
    #list_node{val = V} = N when V >= 10 ->
      add2_(N1#list_node{val = (N1#list_node.val + 1)}, #list_node{val=0}, N#list_node{val=(V-10)});
    _ ->
      add2_(N1, #list_node{val=0}, NowNode)
  end;
add2_(#list_node{val = V1, next=N1} = _,
      #list_node{val = V2, next=N2} = _,
      PreviousNode) ->
  NowNode = #list_node{val = (V1+V2), next = PreviousNode},
  case NowNode of
    #list_node{val = V} = N when V >= 10 ->
      add2_(N1#list_node{val = (N1#list_node.val + 1)}, N2, N#list_node{val=(V-10)});
    _ ->
      add2_(N1, N2, NowNode)
  end.


reverse_(#list_node{next = null} = NowN, Previous) ->
  NowN#list_node{next=Previous};
reverse_(#list_node{next=Next}=NowN, Previous) ->
  NewNow = NowN#list_node{next=Previous},
  reverse_(Next, NewNow).


size_(#list_node{next=null}, Acc) ->
  Acc + 1;
size_(#list_node{next=N}, Acc) ->
  size_(N, Acc + 1).