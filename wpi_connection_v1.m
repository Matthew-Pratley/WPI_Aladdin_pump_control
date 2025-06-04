function [s_connect, message] = wpi_connection_v1(port, address);
% function for connecting to a WPI Aladdin Syringe Pump

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If the current address is unknown press and hold the diameter key on the
% pump to access the pump setup and look for Ad:NN in this the NN will be the current pump address 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
% ports - this is the comport you want to connect to Eg: 'COM3'
% address - this is the address of the pump, automatically set to 00 but can be changed  
%
% Output:
% s_connect - the connection to the serial port
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Matthew Pratley
% Date 29/05/2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% no imput assumes the connection is to port 1
if nargin ==0
    port = 'Com1';
end

if nargin == 1
    address = 00;
end

% creates serial connection to device
s_connect = serialport(port, 19200, "FlowControl","none", "Parity","none", "Timeout",5.0);
configureTerminator(s_connect, 'CR');

% Checks and confirms connection
% flushes pump to remove any previous data written or existing 
flush(s_connect);

% asks pump for address
writeline(s_connect, append(num2str(address), 'ADR'));

% pauses to allow for all data to be written to pump
pause(0.5)

% counts the bytes that the pump responds with  
bytes_avail = s_connect.NumBytesAvailable;

% pauses to allow a full read of the pump 
pause(0.5)

try
% reads the response from the pump
resp = read(s_connect, bytes_avail, 'char');
catch
    message=('Error response from pump not received, please check the connection.');
    disp(message);
end

%  undertakes check of response from pump

if bytes_avail == 7;
    message = append('Connected to pump at ', port, ' address: ', resp(:, 2:3));
    disp(message);
end

end

