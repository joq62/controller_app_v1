%%%-------------------------------------------------------------------
%% @doc controller_app public API
%% @end
%%%-------------------------------------------------------------------

-module(controller_app_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    io:format("config ~p~n",[application:start(config_app)]),
    io:format("log ~p~n",[application:start(log_app)]),
    controller_app_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
