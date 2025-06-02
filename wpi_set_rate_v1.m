function [message] = wpi_set_rate_v1(s_connect, value, set_unit, address)
% function for changing settings on a WPI Aladdin Syringe Pump

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If the current address is unknown press and hold the diameter key on the
% pump to access the pump setup and look for Ad:NN in this the NN will be the current pump address 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
% s_connect - this is the current connection to the syringe pump Eg: pump 
% value - the numerical value you wish to set that setting to Eg: 40
% *********value also has the special case of being set to read to read the current flow rate by using 'read' ************
%
% unit - optional but reccommended, the unit you wish to pump in at inputs are described below:
% 'mLh' - mL per hour 
% 'mLm' - mL per minute 
% 'uLh' - uL per hour
% 'uLm' - uL per minute 
%
% address (optional) the address will automatically be 00 if it is any other input should be '01' or 'NN' where N is the number between 1-99 
%
% Output:
% text confirmation of the change in rate for the pump in the command line 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Matthew Pratley
% Date 29/05/2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% tests for string in value

text_test = ischar(value);

if text_test==1;
    if nargin == 2;
        address =0;
    end

     % clears memory to allow for a fresh read
    flush(s_connect)
    pause(0.5)

    %reads the new syringe diameter from pump
    writeline(s_connect, append(num2str(address), 'RAT'));
    pause(0.5);
    
    % Extracts data from the new read of the syringe
    bytes_avail = s_connect.NumBytesAvailable;

    % puts in a catch to determine if the read was sucessful
    try
        resp = read(s_connect,bytes_avail, 'char');
    catch
    end

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
    
    % writes the current setting that the
    message = (append('Current flow rate set to ', resp(5:9), ' ', text_unit));
    disp(message);
    end

elseif text_test ==0; 

    % if no address is given then automatically sets the address
    if nargin == 3;
        address = '00';
    end

    if size(set_unit) == 0
        if nargin == 4;
            address= address;
        else
            address = '00';
        end
    
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

    % gets diameter setting from pump
    set_diam = str2num(resp(5:9)); 


    % sets volume unit based off of pump diameter settings extracted from above
    if set_diam <= 14;
        set_unit = 'uLm';
        message = (append('Input rate unit set to ', set_unit, ', to change please set pump diameter to greater than 14 mm for mL.', newline, 'Alternatively, add a unit value into input position 3.'));
        disp(message);
    else 
        set_unit = 'mLm';
        message =(append('Input Rate unit set to ', set_unit, ', to change please set pump parameter to less than 14 mm for uL.', newline, 'Alternatively, add a unit value into input position 3.'));
        disp(message);
    end
end 

% reads current rate settings 
% clears pump memory
flush(s_connect)

% writes to pump 
writeline(s_connect, append(num2str(address),'RAT'))
pause(0.5)

% Extracts data from the new read of the syringe
bytes_avail = s_connect.NumBytesAvailable;

% puts in a catch to determine if the read was sucessful
try
    resp = read(s_connect,bytes_avail, 'char');
catch
end

if bytes_avail ==0;
    message = ('No data read, please check the pump connection or address');
    disp(message);
else 
    if contains(resp(10:11), 'MM')
        text_unit = 'ML per min';
    elseif contains(resp(10:11), 'UM')
        text_unit = 'uL per min';
    elseif contains(resp(10:11), 'MH')
        text_unit = 'mL per hour';
    elseif contains(resp(10:11), 'UH')
        text_unit = 'uL per hour';
    end
    
    % writes the current setting that the
    message =(append('Current flow rate set to ', resp(5:9), ' ', text_unit));
    disp(message);
end

% translates unit into write unit which is input for the pump
if contains(set_unit, 'mLm')
    write_unit = 'MM';
elseif contains(set_unit,'mLh')
    write_unit = 'MH';
elseif contains(set_unit, 'uLm')
    write_unit = 'UM';
elseif contains(set_unit, 'uLh')
    write_unit = 'UH';
end

% clears pump memory ready for new write
flush(s_connect);

% writes new value and unit for rate
% writes to pump 
writeline(s_connect, append(num2str(address),'RAT', num2str(value), write_unit))
pause(0.5)

% flushes memory ready for read
flush(s_connect)

% asks pump for read
writeline(s_connect, append(num2str(address),'RAT'));
pause(0.5)
% Extracts data from the new read of the syringe
bytes_avail = s_connect.NumBytesAvailable;

% puts in a catch to determine if the read was sucessful
try
    resp = read(s_connect,bytes_avail, 'char');
catch
end

% finds unit
if contains(resp(10:11), 'MM')
    read_unit = 'mLm';
    text_unit = 'mL per minute';
elseif contains(resp(10:11), 'UM')
    read_unit = 'uLm';
     text_unit = 'uL per minute';
elseif contains(resp(10:11), 'MH')
    read_unit = 'mLh';
     text_unit = 'mL per hour';
elseif contains(resp(10:11), 'UH')
    read_unit = 'uLh';
     text_unit = 'uL per hour';
end

    if set_unit == read_unit; 
        if value == str2num(resp(5:9));
            message = (append('New flow rate set to ' , resp(5:9), ' ', num2str(text_unit)'.'));
            disp(message)
        else
            message = (append('Error setting flow rate, but unit correct please check input value.'));
            disp(message)
        end
    else
        message = ('Error setting unit please check input.');
        disp(message)
end
end
end
