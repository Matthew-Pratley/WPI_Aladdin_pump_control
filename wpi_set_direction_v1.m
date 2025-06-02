function [message] = wpi_set_direction_v1(s_connect, state, address)
% function for changing the pumping direction on a WPI Aladdin 4000 Syringe Pump

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If the current address is unknown press and hold the diameter key on the
% pump to access the pump setup and look for Ad:NN in this the NN will be the current pump address 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
% s_connect - this is the current connection to the syringe pump Eg: pump 
% state - this is start or stop depending on what you want the pump to do
% should either be 'infuse' to make the pump inject or 'withdraw' to make the pump take in solution
% address (optional) the address will automatically be 00 if it is any other input should be 01 or NN where N is the number between 1-99 
%
% Output:
% confirmation of the direction the pump is set in 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Matthew Pratley
% Date 29/05/2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if no address is given then automatically sets the address
if nargin == 2;
    address = '00';
end

% sets pump to read mode
if contains(state, 'read');

    % clears pump memory ready for read
    flush(s_connect)

    % reads current direction set for the pump
    writeline(s_connect, append(num2str(address), 'DIR'));
    pause(0.5)

    % reads pump for dispensed value extracts data from the read from the pump
    bytes_avail = s_connect.NumBytesAvailable;

    % puts in a catch to determine if the read was sucessful
    try
        resp = read(s_connect,bytes_avail, 'char');
    catch
    end

    % catches incorrect address or pump error
    if bytes_avail ==0; 
        message=(append('Error syringe diameter not set, current diameter is ', resp(5:9), ' mm'));
        disp(message);
    end

    % ouputs current state of pump
    if contains(resp(5:7), 'INF')
        message=('Pump is currently set to infuse.');
        disp(message);
    elseif contains(resp(5:7), 'WDR')
        message=('Pump is currently set to withdraw.');
        disp(message);
    else
        message=('Error in getting information please check pump connection or address');
        disp(message)
    end

% sets pump to infuse mode
elseif contains(state, 'infuse');
      flush(s_connect)

    % reads current direction set for the pump
    writeline(s_connect, append(num2str(address), 'DIRINF'));
    pause(0.5)

    % reads pump for dispensed value extracts data from the read from the pump
    bytes_avail = s_connect.NumBytesAvailable;

    % puts in a catch to determine if the read was sucessful
    try
        resp = read(s_connect,bytes_avail, 'char');
    catch
    end

    % catches incorrect address or pump error
    if bytes_avail ==0; 
        message=('No readable data, please check the pump address or the connection');
        disp(message);
    else
        message =('Pump direction set to infuse');
        disp(message);
    end

% sets pump to withdraw mode
elseif contains(state, 'withdraw');
    flush(s_connect)

    % reads current direction set for the pump
    writeline(s_connect, append(num2str(address), 'DIRWDR'));
    pause(0.5)

    % reads pump for dispensed value extracts data from the read from the pump
    bytes_avail = s_connect.NumBytesAvailable;

    % puts in a catch to determine if the read was sucessful
    try
        resp = read(s_connect,bytes_avail, 'char');
    catch
    end

    % catches incorrect address or pump error
    if bytes_avail ==0; 
        message= ('No readable data, please check the pump address or the connection');
        disp(message);
    else
        message =('Pump direction set to withdraw');
        disp(message);
    end

% catches invalid inputs    
else
    message=('Invalid input please change to either "read", "infuse" or "withdraw"');
    disp(message);
end

end