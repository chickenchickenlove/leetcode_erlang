%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. 10월 2023 오후 9:15
%%%-------------------------------------------------------------------
-module(lc33).

%% API
-export([test/0, search/2, test2/0]).

-spec search(Nums :: [integer()], Target :: integer()) -> integer().
search(Nums, Target) ->
  s(Nums, Target).

s(N, T) ->
  Tuple = list_to_tuple(N), Len = tuple_size(Tuple),

  case element(1, Tuple) > element(Len, Tuple) of
    false -> MaxValue = element(Len, Tuple), MaxIdx = Len;
    true -> MaxValue = element(1, Tuple), MaxIdx = 1
  end,

  End = sol(Tuple, 1, Len, MaxValue, MaxIdx),
  NStart = End + 1, NEnd = End + Len,
  sol2(Tuple, NStart, NEnd, T).

get_func(N, Len)->
  case N > Len of
    false -> N;
    true -> N - Len
  end.


%% 타겟값 이분탐색
sol2(_, L, R, _) when L > R ->
  -1;
sol2(Nums, L, R, Target) ->
  M = (L+R) div 2,ML = get_func(M, tuple_size(Nums)), Mv = element(ML, Nums),
  if
    Mv == Target -> ML-1 ;
    Mv < Target -> sol2(Nums, M+1, R, Target);
    true -> sol2(Nums, L, M-1, Target)
  end.

%% 최대값 이분탐색
sol(_, L, R, _, MaxIdx) when L > R->
  MaxIdx;
sol(Numbers, L, R, MaxValue, MaxIdx) ->
  M = (L+R) div 2, Lv = element(L, Numbers), Rv = element(R, Numbers), Mv = element(M, Numbers),

  if
    Lv > Rv andalso Lv > Mv ->
      if
        Lv > MaxValue -> sol(Numbers, L, M-1, Lv, L);
        true -> sol(Numbers, L, M-1, MaxValue, MaxIdx)
      end;
    true ->
      if
        Mv > Rv andalso Mv > MaxValue -> sol(Numbers, M+1, R, Mv, M);
        Mv < Rv andalso Rv > MaxValue -> sol(Numbers, M+1, R, Rv, R);
        true -> sol(Numbers, M+1, R, MaxValue, MaxIdx)
      end
  end.



test2() ->
  A = 1,
  B = 2,
  case A < B of
    false -> MaxValue = 2, MaxIdx = 2;
    true -> MaxValue = 1, MaxIdx = 1
  end,
  io:format("MaxValue ~p MaxIdx ~p ~n", [MaxValue, MaxIdx]).



test() ->
  N = [4,5,6,7,0,1,2],
  Tuple = list_to_tuple(N),
  T = 0,

  Len = tuple_size(Tuple),
  MaxValue = max(element(1, Tuple), element(Len, Tuple)),
  MaxIdx = if
             element(1, Tuple) > element(Len, Tuple) -> 1;
             true ->  Len
           end,

  End = sol(Tuple, 1, Len, MaxValue, MaxIdx),

  NStart = End + 1,
  NEnd = End + Len,
  sol2(Tuple, NStart, NEnd, T).