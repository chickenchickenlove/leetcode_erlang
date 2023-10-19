%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 19. 10월 2023 오후 5:55
%%%-------------------------------------------------------------------
-module(lc454).

%% API
-export([test/0]).

-spec four_sum_count(Nums1 :: [integer()], Nums2 :: [integer()], Nums3 :: [integer()], Nums4 :: [integer()]) -> integer().
four_sum_count(Nums1, Nums2, Nums3, Nums4) ->
  sol(Nums1, Nums2, Nums3, Nums4).

sol1(A,B) ->
  [X + Y || X <- A, Y <- B].

sol2(L) ->
  lists:foldl(fun(X, Acc) ->
    maps:update_with(X, fun(X) -> X+1 end, 1, Acc) end,
    #{}, L).

sol(N1, N2, N3, N4) ->
  A = sol2(sol1(N1, N2)),
  B = sol2(sol1(N3, N4)),
  lists:foldl(fun(X, Acc) -> Acc + maps:get(-X, B, 0) * maps:get(X, A) end, 0, maps:keys(A)).




%%  D1 = lists:foldl(fun(X, Acc) -> s1(X, RN2, Acc) end, #{}, RN1),
%%  D2 = lists:foldl(fun(X, Acc) -> s1(X, RN4, Acc) end, #{}, RN3),

%%  Keys = maps:keys(D1),
%%  s2(Keys, D1, D2, 0)

s1(_, [], Acc) ->
  Acc;
s1(Num, [H|T], Acc) ->
  Value = maps:get(Num + H, Acc, 0),
  Key = Num + H,
  s1(Num, T, Acc#{Key => Value +1}).


s2([], _, _, Acc) ->
  Acc;
s2([H|T], D1, D2 , Acc) ->
  V2 = maps:get(H, D1),
  V1 = maps:get(-H, D2, 0),
  s2(T, D1, D2, Acc + (V1*V2)).



test() ->
  N1 = [1,2],
  N2 = [-2,-1],
  N3 = [-1,2],
  N4 = [0,2],
  sol(N1, N2, N3, N4).