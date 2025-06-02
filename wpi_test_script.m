%% this script was used to develop the functions and to test that they were all working it then becomes the example script which is the more up to date version

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Written by: Matthew Pratley
% Date 29/05/2025
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% connect to pump with no address 
port = 'COM6';

pump = wpi_connection_v1(port);

%% connect to pump with address NN where NN is a number between 1-99

port = 'COM3';

pump = wpi_connection_v1(port, 10);


%% change address of pump

wpi_set_address_v1(pump, 10, 00); 

%% change the diameter of a pump with address 00 

wpi_set_diam_v1(pump, 10);

%% change the diamter of a pump with address NN where NN is a number between 1-99

wpi_set_diam_v1(pump, 25, 10);

%% read the diameter of a pump with address 00 

wpi_set_diam_v1(pump, 'read');

%% read the diamter of a pump with address NN where NN is a number between 1-99

wpi_set_diam_v1(pump, 'read', 10);


%% change the volume to be pumped with address 00 

wpi_set_volume_v1(pump, 25);


%% change the volume to be pumped with address NN where NN is a number between 1-99

wpi_set_volume_v1(pump, 20, 10);

%% read the volume to be pumped with address 00 

wpi_set_volume_v1(pump, 'read');


%% read the volume to be pumped with address NN where NN is a number between 1-99

wpi_set_volume_v1(pump, 'read', 10);


%% reads volume dispensed from pump with address 00

wpi_read_volume_dispensed_v1(pump);

%% reads volume dispensed from pump with address NN where NN is a number between 1-99 

wpi_read_volume_dispensed_v1(pump, 20);

%% start and stop pump with address 00

% starts pump
wpi_start_stop_v1(pump, 'start');

% stops pump 
wpi_start_stop_v1(pump, 'stop');

% invalid input test 
wpi_start_stop_v1(pump, 'test');

%% start and stop pump with address NN where NN is a number betwen 1-99

% starts pump
wpi_start_stop_v1(pump, 'start', 23);

% stops pump 
wpi_start_stop_v1(pump, 'stop', 23);

% invalid input test 
wpi_start_stop_v1(pump, 'test', 23);

%% direction read and set for a pump at address 00

wpi_set_direction_v1(pump, 'read');

wpi_set_direction_v1(pump, 'infuse');

wpi_set_direction_v1(pump, 'withdraw');

%% direction read and set for a pump at address NN where NN is a number between 1 and 99 

wpi_set_direction_v1(pump, 'read', 27);

wpi_set_direction_v1(pump, 'infuse', 27);

wpi_set_direction_v1(pump, 'withdraw', 27);

%% pump reset for pump with address 00 

wpi_reset_v1(pump)

%% pump reset for pump with address NN where NN is a number between 1 and 99 

wpi_reset_v1(pump, 34);

%% changes and reads rate settings for pump with no address included 

% reads rate from pump 
wpi_set_rate_v1(pump, 'read');

% sets pump with no address and no attached unit 
wpi_set_rate_v1(pump, 2);

% sets pump with no address but unit included
wpi_set_rate_v1(pump, 5, 'mLm');

%% changes and reads rate settings for pump with address NN where NN is a number between 1 and 99

% reads rate from pump 
wpi_set_rate_v1(pump, 'read', '', 39);

% sets pump with no address and no attached unit 
wpi_set_rate_v1(pump, 2, '', 39);

% sets pump with address and unit included
wpi_set_rate_v1(pump, 5, 'mLm', 39);















