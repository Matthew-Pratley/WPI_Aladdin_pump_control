function [message, timeVar] = wpi_change_rate_v1(s_connect, value, address)
% function for changing the flow rate whilst pumping for a WPI Aladdin pump

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If the current address is unknown press and hold the diameter key on the
% pump to access the pump setup and look for Ad:NN in this the NN will be the current pump address 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
% s_connect - this is the current connection to the syringe pump Eg: pump 
% value - the numerical value you wish to set the rate to
% address (optional) the address will automatically be 00 if it is any other input should be '01' or 'NN' where N is the number between 1-99 
%
% Output:
% text confirmation of the rate currently set for the pump
% t_var
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Matthew Pratley
% Date 28/07/2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% timings for troubleshooting/debugging the process
t_var = [];

% if no address is given then automatically sets the address
if nargin == 3;
     address = '00';
end

% clears memory on pump
flush(s_connect)
pause(0.05)

% stops pump to allow new rate to be set
[t_message] = wpi_start_stop_v1(s_connect, 'stop', address)
fprintf(t_message);
t_var.TimeStop=(datetime('now'))

% sets new rate for the pump - must be rounded to 3 dp this is built into
% the function through round(value, 3)
[message]=wpi_set_rate_v1(s_connect, round(value,3), 'mLm', address);
fprintf(message);
t_var.TimeSet=(datetime('now'))

% restarts pump at new rate
[t_message] =wpi_start_stop_v1(pump_1, 'start')
fprintf(t_message);
t_var.TimeStart=(datetime('now'))

% reads new set rate from pump
[t_message]=wpi_set_rate_v1(pump_1, 'read')
fprintf(t_message);
t_var.TimeRead=(datetime('now'));

end


