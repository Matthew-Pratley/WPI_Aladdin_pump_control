function [message] = wpi_set_address_v1(s_connect, curr_add, new_add);
% function for changing the address of a WPI Aladdin Syringe Pump

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% If the current address is unknown press and hold the diameter key on the
% pump to access the pump setup and look for Ad:NN in this the NN will be the current pump address 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
% s_connect - this is the current connection to the syringe pump Eg: pump 
% curr_add - this is the current address of the pump if not used previously
% the address should be 00 Eg: '00' or 'NN' where N is the number between 1-99 
% new_add - this is the new address that the pump will be at Eg: '00' or 'NN' where N is the number between 1-99 
%
%
% Output:
% text confirmation of the change in address of the pump in the command line 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Matthew Pratley
% Date 29/05/2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ensures the addresses input are valid
if new_add > 99 | curr_add > 99;
    message=(append('Address greater than 99 impossible please input a new or current address lower than 99'));
    disp(message);
else

    % reads current address of pump 
    writeline(s_connect, append(num2str(curr_add), 'ADR'));
    pause(0.5)
    
    % checks if read was successful 
    bytes_avail = s_connect.NumBytesAvailable;
    pause(0.5)

    % catches if the read was unsucessful
    if bytes_avail == 0;
        message=('Wrong current address, please check the input value');
        disp(message); 
    else
        resp = read(s_connect, bytes_avail, "char");
        message=(append('Current address is: ', resp(:, 2:3)));
        disp(message);

    % flushes the pump comport to allow for new write
    flush(s_connect)

    % sets a new address for the pump based off the input new add
    writeline(s_connect, append(num2str(curr_add), 'ADR', num2str(new_add)));
    pause(0.5)

    % checks for suceassful write
    bytes_avail = s_connect.NumBytesAvailable;
    pause(0.5)

    % extracts data to determine sucess
    resp = read(s_connect, bytes_avail, "char");
    
    % output statements determined from the values above
    if str2num(resp(:, 2:3)) == new_add;
        message=(append('Address set to: ', resp(:, 2:3) ))
        disp(message);
    else
        message=(append('Error setting address current address is ', resp(:, 2:3) ));
        disp(message);
    end
end
end