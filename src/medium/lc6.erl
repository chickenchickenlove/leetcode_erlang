%%%-------------------------------------------------------------------
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 07. 1월 2024 오전 9:03
%%%-------------------------------------------------------------------
-module(lc6).

%% API
-export([]).
-spec convert(S :: unicode:unicode_binary(), NumRows :: integer()) -> unicode:unicode_binary().
convert(S, NumRows) ->
  case NumRows of
    1 -> S;
    _ ->
      Str = binary_to_list(S),
      Result = #{Key => [] || Key <- lists:seq(1, NumRows)},
      R = 1,
      convert_(Str, Result, R, NumRows, true)
  end.

convert_([], Result, R, Limit, Flag) ->
  Fun = fun(Key, List, Acc) ->
    Acc#{Key => lists:reverse(List)}
    end,
  R0 = maps:fold(Fun, #{}, Result),
  R1 = [maps:get(N, R0) || N <- lists:seq(1, Limit)],
  R2 = lists:flatten(R1),
  list_to_binary(R2);
convert_([H|T], Result, R, Limit, Flag) when R == Limit orelse R == 1 ->
  List = maps:get(R, Result),
  NewResult = Result#{R => [H|List]},
  case R of
    R = Limit -> convert_(T, NewResult, R-1, Limit, false);
    R = 1     -> convert_(T, NewResult, R+1, Limit, true)
  end;
convert_([H|T], Result, R, Limit, Flag)->
  List = maps:get(R, Result),
  NewResult = Result#{R => [H|List]},
  case Flag of
    true -> convert_(T, NewResult, R+1, Limit, Flag);
    _    -> convert_(T, NewResult, R-1, Limit, Flag)
  end.
