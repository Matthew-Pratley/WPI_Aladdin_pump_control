function [s_connect] = wpi_volume_dis_v1(s_connect, state, address)
% function for changing settings on a WPI Aladdin Syringe Pump

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If the current address is unknown press and hold the diameter key on the
% pump to access the pump setup and look for Ad:NN in this the NN will be the current pump address 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
% s_connect - this is the current connection to the syringe pump Eg: pump 
% state - This decides whether read or clear is selected. To read the
% volume dispensed an input of 'read' is required, to clear the volume dispensed an input of 'clear' is required.  
% address (optional) the address will automatically be 00 if it is any other input should be '01' or 'NN' where N is the number between 1-99 
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

if contains(state, 'read')

    % clears pump memory ready for read 
    flush(s_connect)

    % writes asking for volume dispensed value to the pump
    writeline(s_connect, append(num2str(address), 'DIS'));
    pause(0.5)

    % reads pump for dispensed value extracts data from the read from the pump
    bytes_avail = s_connect.NumBytesAvailable;

    % puts in a catch to determine if the read was sucessful
    try
    resp = read(s_connect,bytes_avail, 'char');
    catch
    end

    % creates output statement for the command line depending on the outcomes above 
    if bytes_avail == 0;
        disp('No bytes available, please check the pump address or connection')
    else
        disp(append('Volume infused: ', resp(6:10), ' ', resp(17:18), ',  Volume Withdrawn: ', resp(12:16), ' ', resp(17:18)));
    end

elseif contains(state, 'clear');
    
    %clears pump memory ready for write 
    flush(s_connect)

    % writes asking for volume dispensed value to the pump
    writeline(s_connect, append(num2str(address), 'CLDINF'));
    pause(0.5)
    writeline(s_connect, append(num2str(address), 'CLDWDR'));
    pause(0.5)

    % reads pump for dispensed value extracts data from the read from the pump
    bytes_avail = s_connect.NumBytesAvailable;

    % puts in a catch to determine if the read was sucessful
    try
    resp = read(s_connect,bytes_avail, 'char');
    catch
    end

    % creates output statement for the command line depending on the outcomes above 
    if bytes_avail == 0;
        disp('No bytes available, please check the pump address or connection')
    else
        disp(append('Volume dispensed cleared.'));
    end

else
    disp('Invalid input, please either input "read" to read the volumes dispensed or "clear" to reset the volume dispsnsed to 0')
end

end





