function [message, flowRate, t_var] = wpi_change_rate_v1(s_connect, value, address)
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
if nargin == 2;
     address = '00';
end

% clears memory on pump
flush(s_connect)
pause(0.05)

% stops pump to allow new rate to be set
writeline(s_connect, append(num2str(address), 'STP'));
t_var.TimeStop=(datetime('now'));
pause(0.05)

% sets new rate for the pump - must be rounded to 3 dp this is built into
% the function through round(value, 3)
writeline(s_connect, append(num2str(address),'RAT', num2str(round(value,3)), 'MM'));
t_var.TimeSet=(datetime('now'));
pause(0.05)

% restarts pump at new rate
writeline(s_connect, append(num2str(address), 'RUN'));
t_var.TimeStart=(datetime('now'));
pause(0.05)

% flushes pump before read
flush(s_connect)
pause(0.05)

% reads new set rate from pump
writeline(s_connect, append(num2str(address), 'RAT'));
t_var.TimeRead=(datetime('now'));
pause(0.05)

% Extracts data from the new read of the syringe
bytes_avail = s_connect.NumBytesAvailable;

% response from pump
try
    resp = read(s_connect, bytes_avail, 'char');
catch
end

% reads response
if bytes_avail ==0;
   message = ('No data read, please check the pump connection or address');
   disp(message);
else 
    if contains(resp(10:11), 'MM')
        text_unit = 'mL per min';
    elseif contains(resp(10:11), 'UM')
        text_unit = 'uL per min';
    elseif contains(resp(10:11), 'MH')
        text_unit = 'mL per hour';
    elseif contains(resp(10:11), 'UH')
        text_unit = 'uL per hour';
    end
end
    
% writes the current setting that the
flowRate = str2num(resp(5:9)); 

% tests for correct flow rate
if flowRate == round(value,3);
    message = append('Current flow rate set to ', num2str(flowRate), ' ', text_unit);
else
    message = append('Error setting flow rate, Target value: ', num2str(value), ' set value: ', num2str(flowRate), '.');
end
% displays message 
% disp(message);
end


