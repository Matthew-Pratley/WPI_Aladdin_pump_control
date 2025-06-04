function [message] = wpi_set_volume_v1(s_connect, value, address)
% function for changing settings on a WPI Aladdin Syringe Pump

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If the current address is unknown press and hold the diameter key on the
% pump to access the pump setup and look for Ad:NN in this the NN will be the current pump address 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
% s_connect - this is the current connection to the syringe pump Eg: pump 
% value - the numerical value you wish to set that setting to Eg: 40 this will always be in mL
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

    % clears pump memory ready for a read
    flush(s_connect)
    pause(0.5)

    % reads new volume data from the pump
    writeline(s_connect, append(num2str(address), 'VOL'));
    pause(0.5);

    % extracts data from the read from the pump
    bytes_avail = s_connect.NumBytesAvailable;

    % puts in a catch to determine if the read was sucessful
    try
        resp = read(s_connect,bytes_avail, 'char');
    catch
    end

    set_diam = str2num(resp(5:9)); 


    % sets volume unit based off of pump diameter settings extracted from above
    if set_diam <= 14;
        volume_unit = 'uL';
        disp(append('Volume is set to ', resp(5:9), ' ', volume_unit));
    else 
        volume_unit = 'mL';
        disp(append('Volume is set to ', resp(5:9), ' ', volume_unit));
    end

    % creates output statement for the command line depending on the outcomes above 
    if bytes_avail == 0;
        message =('No bytes available, please check the pump address or connection');
        disp(message)
    elseif str2num(resp(:, 5:9)) == value;
        message =(append('Volume set to: ', resp(:,5:9), volume_unit));
       disp(message);
    end

elseif text_test ==0;    

% extracts the set diameter from the pump as the volume is dependent on the pump diameter
writeline(s_connect, append(num2str(address), 'DIA'));
pause(0.5)
bytes_avail = s_connect.NumBytesAvailable;
pause(0.5)
resp = read(s_connect, bytes_avail, 'char');
set_diam = str2num(resp(5:9)); 


% sets volume unit based off of pump diameter settings extracted from above
if set_diam <= 14;
    volume_unit = 'uL';
    message= (append('Volume unit set to ', volume_unit, ', to change please set pump diameter to greater than 14 mm for mL'));
    disp(message);
else 
    volume_unit = 'mL';
    message = (append('Volume unit set to ', volume_unit, ', to change please set pump parameter to less than 14 mm for uL'));
    disp(message);
end

% sets a rule for the maximum available volume for the two syringes the maximum is 2 x 60 mL syringes giving 120 mL in total
if value > 120;
    disp('Volume cannot be larger than 120 mL (2 x 60 mL syringes), please input valid value')
else
    % clears pump memory ready for new value 
    flush(s_connect)
    
    % writes new volume value to the pump
    writeline(s_connect, append(num2str(address), 'VOL', num2str(value)));
    pause(0.5)
    
    % clears pump memory ready for a read
    flush(s_connect)
    pause(0.5)

    % reads new volume data from the pump
    writeline(s_connect, append(num2str(address), 'VOL'));
    pause(0.5);

    % extracts data from the read from the pump
    bytes_avail = s_connect.NumBytesAvailable;

    % puts in a catch to determine if the read was sucessful
    try
        resp = read(s_connect,bytes_avail, 'char');
    catch
    end

    % creates output statement for the command line depending on the outcomes above 
    if bytes_avail == 0;
        message = ('No bytes available, please check the pump address or connection') 
        disp(message)
    elseif str2num(resp(:, 5:9)) == value;
        message = (append('Volume set to: ', resp(:,5:9), ' ', volume_unit));
       disp(message);
    else
        message = (append('Error volume not set, current set volume is ', resp(5:9), ' ', volume_unit));
        disp(message);
    end
end
end
end



