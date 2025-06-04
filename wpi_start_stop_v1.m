function [message] = wpi_start_stop_v1(s_connect, state, address)
% function for changing settings on a WPI Aladdin Syringe Pump

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If the current address is unknown press and hold the diameter key on the
% pump to access the pump setup and look for Ad:NN in this the NN will be the current pump address 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
% s_connect - this is the current connection to the syringe pump Eg: pump 
% state - this is start or stop depending on what you want the pump to do should either be 'start' to start pump or 'stop' to stop pump 
% address (optional) the address will automatically be 00 if it is any other input should be 01 or NN where N is the number between 1-99 
%
% Output:
% text value of the volume dispensed
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Matthew Pratley
% Date 29/05/2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if no address is given then automatically sets the address
if nargin == 2;
    address = '00';
end

% clears pump memory ready for write 
flush(s_connect)

if contains(state, 'start');
    % writes telling pump to start
    writeline(s_connect, append(num2str(address), 'RUN'));
    pause(0.5)
    message = (append('Pump ', num2str(address), ' ', 'started.'));
    disp(message);
    % clears pump memory
    flush(s_connect)

elseif contains(state,'stop');
    writeline(s_connect, append(num2str(address), 'STP'));
    pause(0.5)
    message = (append('Pump ', num2str(address), ' ', 'stopped.'));
    disp(message);
    % clears pump memory
    flush(s_connect)
else
    message =('Invalid input please change to either "start", or "stop"');
    disp(message);

end
end




