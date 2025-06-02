function [message] = wpi_reset_v1(s_connect, address)
% function for changing settings on a WPI Aladdin Syringe Pump

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If the current address is unknown press and hold the diameter key on the
% pump to access the pump setup and look for Ad:NN in this the NN will be the current pump address 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
% s_connect - this is the current connection to the syringe pump Eg: pump 
% address (optional) the address will automatically be 00 if it is any other input should be '01' or 'NN' where N is the number between 1-99 
%
% Output:
% text showing pump was reset
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Matthew Pratley
% Date 29/05/2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if no address is given then automatically sets the address
if nargin == 1;
    address = '00';
end

% clears pump comport ready for reset
flush(s_connect)

% writes reset command to pump
writeline(s_connect, append('*RESET'));
pause(0.5)

% reads pump for dispensed value extracts data from the read from the pump
bytes_avail = s_connect.NumBytesAvailable;

% puts in a catch to determine if the read was sucessful
try
    resp = read(s_connect,bytes_avail, 'char');
catch
end

% output statements
if str2num(resp(2:3)) == 0;
    message = ('Pump reset complete.');
    disp(message);
else
    message = ('Error in reset please check pump connection or address'); 
    disp(message);
end
