%%%-------------------------------------------------------------------
%%% @copyright (C) 2023, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 13. 10월 2023 오후 2:01
%%%-------------------------------------------------------------------
-module(lc4).

%% API
-export([test/2]).



-spec find_median_sorted_arrays(Nums1 :: [integer()], Nums2 :: [integer()]) -> float().
find_median_sorted_arrays(Nums1, Nums2) ->
  test(Nums1, Nums2).


test(Nums1, Nums2) ->
  MergedNums = Nums1 ++ Nums2,
  SortedNums = lists:sort(MergedNums),
  Length = length(SortedNums),
  MidPosition = (Length div 2) + 1,
  if
    (Length rem 2) == 1 -> lists:nth(MidPosition, SortedNums);
    true -> (lists:nth(MidPosition-1, SortedNums) + lists:nth(MidPosition, SortedNums)) / 2
  end.
