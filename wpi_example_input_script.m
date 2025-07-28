
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script gives example inputs of every function used to control the
% WPI Aladdin pumps. 
% These functions have been tested as of 29/05/2025 and all work.
% 
% For any issues with control please checdk the read me sheet within the folder. 
% For further questions on how to use the functions please contact me
%
% Written by: Matthew Pratley
% Date 29/05/2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% connect to pump with no address 
port = 'COM3';

pump = wpi_connection_v1(port);

%% connect to pump with address NN where NN is a number between 1-99 in this example address is set to '28'

port = 'COM3';

pump = wpi_connection_v1(port, 28);


%% change address of pump

wpi_set_address_v1(pump, 00, 00); 

%% change the diameter of a pump to 10 with address 00

wpi_set_diam_v1(pump, 10);

%% change the diameter of a pump to 10 with address NN where NN is a number between 1-99 in this example address is set to '28'

wpi_set_diam_v1(pump, 10, 28);

%% read the diameter of a pump with address 00 

wpi_set_diam_v1(pump, 'read');

%% read the diameter of a pump with address NN where NN is a number between 1-99 in this example address is set to '28'

wpi_set_diam_v1(pump, 'read', 28);


%% change the volume to be pumped with address 00 

wpi_set_volume_v1(pump, 25);


%% change the volume to be pumped with address NN where NN is a number between 1-99 in this example address is set to '28'

wpi_set_volume_v1(pump, 20, 28);

%% read the volume to be pumped with address 00 

wpi_set_volume_v1(pump, 'read');


%% read the volume to be pumped with address NN where NN is a number between 1-99 in this example address is set to '28'

wpi_set_volume_v1(pump, 'read', 28);


%% reads volume dispensed from pump with address 00

wpi_volume_dis_v1(pump, 'read');

%% reads volume dispensed from pump with address NN where NN is a number between 1-99 in this example address is set to '28'

wpi_volume_dis_v1(pump, 'read', 28);

%% clears volume dispensed from pump address 00

wpi_volume_dis_v1(pump, 'clear');

%% clears volume dispensed from pump address NN where NN is a number between 1-99 in this example address is set to '28'

wpi_volume_dis_v1(pump, 'clear', 28);


%% start and stop pump with address 00

% starts pump
wpi_start_stop_v1(pump, 'start');

% stops pump 
wpi_start_stop_v1(pump, 'stop');

% invalid input test 
wpi_start_stop_v1(pump, 'test');

%% start and stop pump with address NN where NN is a number betwen 1-99 in this example address is set to '28'

% starts pump
wpi_start_stop_v1(pump, 'start', 28);

% stops pump 
wpi_start_stop_v1(pump, 'stop', 28);

% invalid input test 
wpi_start_stop_v1(pump, 'test', 28);

%% direction read and set for a pump at address 00

wpi_set_direction_v1(pump, 'read');

wpi_set_direction_v1(pump, 'infuse');

wpi_set_direction_v1(pump, 'withdraw');

%% direction read and set for a pump at address NN where NN is a number between 1 and 99 in this example address is set to '28'

wpi_set_direction_v1(pump, 'read', 28);

wpi_set_direction_v1(pump, 'infuse', 28);

wpi_set_direction_v1(pump, 'withdraw', 28);

%% pump reset for pump with address 00 

wpi_reset_v1(pump);

%% pump reset for pump with address NN where NN is a number between 1 and 99 in this example address is set to '28'

wpi_reset_v1(pump, 28);

%% changes and reads rate settings for pump to 2 with no address included 

% reads rate from pump 
wpi_set_rate_v1(pump, 'read');

% sets pump with no address and no attached unit 
wpi_set_rate_v1(pump, 2);

% sets pump with no address but unit included
wpi_set_rate_v1(pump, 2, 'mLm');

%% changes and reads rate settings to 2 for pump with address NN where NN is a number between 1 and 99 in this example address is set to '28'

% reads rate from pump at address 28
wpi_set_rate_v1(pump, 'read', '', 28);

% sets pump with address and no attached unit 
wpi_set_rate_v1(pump, 2, '', 28);

% sets pump with address and unit included
wpi_set_rate_v1(pump, 2, 'mLm', 28);

%% changes pump flow rate

% Change flow rate for a pump currently running with address '00' to 4 mL min^-1
wpi_volume_dis_v1(pump, 4);

% Change flow rate for a pump currently running with address '28' to 4 mL min^-1
wpi_volume_dis_v1(pump, 4, 28);







































