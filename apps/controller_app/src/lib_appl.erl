%%% -------------------------------------------------------------------
%%% Author  : uabjle
%%% Description : dbase using dets 
%%% 
%%% Created : 10 dec 2012
%%% -------------------------------------------------------------------
-module(lib_appl).  
   
%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------

%%---------------------------------------------------------------------
%% Records for test
%%

%% --------------------------------------------------------------------
%-compile(export_all).
-export([
	 create/0,
	 create/1,
	 create/5,
	 delete/1
	]).
	 

%% ====================================================================
%% External functions
%% ====================================================================
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
create()->
    {ok,HostName}=net:gethostname(),
    UniqueNodeName=integer_to_list(erlang:system_time(microsecond),36),
    Cookie=atom_to_list(erlang:get_cookie()),
    PaArgs=" ",
    EnvArgs=" ",
    Result=create(HostName,UniqueNodeName,Cookie,PaArgs,EnvArgs),
    Result.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
create(NodeName)->
    {ok,HostName}=net:gethostname(),
    Cookie=atom_to_list(erlang:get_cookie()),
    PaArgs=" ",
    EnvArgs=" ",
    Result=create(HostName,NodeName,Cookie,PaArgs,EnvArgs),
    Result.
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
% NodeDir=filename:join(NodeName++".pod"),
create(HostName,NodeName,Cookie,PaArgs,EnvArgs)->
    io:format("HostName ~p~n",[HostName]),
    io:format("NodeName ~p~n",[NodeName]),
    io:format("PaArgs ~p~n",[PaArgs]),
    io:format("Cookie ~p~n",[Cookie]),
    io:format("EnvArgs ~p~n",[EnvArgs]),
    
    Args=PaArgs++" "++"-setcookie "++Cookie++" "++EnvArgs,
    Result=case slave:start(HostName,NodeName,Args) of
	       {error,Reason}->
		   {error,[Reason,?MODULE,?LINE]};
	       {ok,SlaveNode}->
		   case net_kernel:connect_node(SlaveNode) of
		       false->
			   {error,[failed_connect,SlaveNode,?MODULE,?LINE]};
		       ignored->
			   {error,[ignored,SlaveNode,?MODULE,?LINE]};
		       true->
			   {ok,SlaveNode}
		   end
	   end,
    Result.

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% -------------------------------------------------------------------	       
delete(Node)->
    slave:stop(Node).
%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------
 

%% --------------------------------------------------------------------
%% Function:start/0 
%% Description: Initiate the eunit tests, set upp needed processes etc
%% Returns: non
%% --------------------------------------------------------------------

    

