function [s_connect, message] = wpi_set_diam_v1(s_connect, value, address)
% function for changing settings on a WPI Aladdin Syringe Pump

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If the current address is unknown press and hold the diameter key on the
% pump to access the pump setup and look for Ad:NN in this the NN will be the current pump address 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
% s_connect - this is the current connection to the syringe pump Eg: pump 
% value - the numerical value you wish to set that setting to Eg: 40
% ******** Value can also be used to read the set diameter using 'read' as an input **********
% address (optional) the address will automatically be 00 if it is any other input should be '01' or 'NN' where N is the number between 1-99 
%
% Output:
% text confirmation of the change in address of the pump in the command line 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Matthew Pratley
% Date 29/05/2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if no address is given then automatically sets the address
if nargin == 2;
    address = '00';
end

% questions if value is 'read'
text_test = ischar(value);

if text_test==1;
    % clears memory to allow for a fresh read
    flush(s_connect)
    pause(0.5)

    %reads the new syringe diameter from pump
    writeline(s_connect, append(num2str(address), 'DIA'));
    pause(0.5);
    
    % Extracts data from the new read of the syringe
    bytes_avail = s_connect.NumBytesAvailable;

    % puts in a catch to determine if the read was sucessful
    try
        resp = read(s_connect,bytes_avail, 'char');
    catch
    end

    % writes out for the read function
    if bytes_avail == 0;
        message=('No bytes available, please check the pump address or connection');
        disp(message)
    else str2num(resp(:, 5:9)) == value;
        message=(append('Syring diameter set to: ', resp(:,5:9), ' mm'));
       disp(message);
    end

elseif text_test ==0

% puts in a catch for the size of the syring used 
if value > 30;
    message=('Syringe diameter cannot be larger than 30 mm, please input valid value');
    disp(message)
else
    % clears pump memory
    flush(s_connect)
    
    % writes the new syringe size to the pump 
    writeline(s_connect, append(num2str(address), 'DIA', num2str(value)));
    pause(0.5)
    
    % clears memory to allow for a fresh read
    flush(s_connect)
    pause(0.5)

    %reads the new syringe diameter from pump
    writeline(s_connect, append(num2str(address), 'DIA'));
    pause(0.5);
    
    % Extracts data from the new read of the syringe
    bytes_avail = s_connect.NumBytesAvailable;

    % puts in a catch to determine if the read was sucessful
    try
        resp = read(s_connect,bytes_avail, 'char');
    catch
    end

    % creates output statement for the command line depending on the outcomes above 
    if bytes_avail == 0;
        message=('No bytes available, please check the pump address or connection');
        disp(message);
    elseif str2num(resp(:, 5:9)) == value;
        message=(append('Syringe diameter set to: ', resp(:,5:9), ' mm'));
       disp(message);
    else
        message=(append('Error syringe diameter not set, current diameter is ', resp(5:9), ' mm'));
        disp(message);
    end
end
end
end



