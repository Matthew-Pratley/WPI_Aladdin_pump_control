WPI Aladdin Drivers

Written in: MATLAB R2024b
Written by: Matthew Pratley
Date: 29/05/2025
Updated: 29/05/2025


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
General:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
The functions contained control the WPI Aladdin Syringe Pumps regardless of model.
They should also compatible for any other brands of the same pump, such as ones offered by New Era, but with the caveat of being untested on other brands. 
Each set function has a built in read feature where if you input 'read' as the input value after the pump it will display the current set value in the command line.
Unless input each function assumes the address of the pump is set to '00', to change this please use the set address function below. 
If unsure of the address prior to connecting the pump please hold down the setup key and look for the code 'Ad:NN' where the NN will be numerical and be the address
the pump is currently set to.    
For all examples of the pump having an address different to '00' in this document the address used will be '28'.
For all examples below the comport connected to will be comport 3 as demonstrated in the examples by 'COM3', your comport number maybe different. 
All of the functions within can also be viewed in the wpi_example_input_script.m within this folder. This file can also be used to test the connection to the pump
and to determine if the functions are working. 
Last test date: 29/05/2025

  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Connecting to syringe pump:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Connects to any WPI Aladdin pump via an RJ11 to RS232 cable. Please ensure that the correct cable is used generic cables may not work unless modified. 

Function: wpi_connection_v1.m
Generic use:
wpi_connection_v1('COMPORT', ADDRESS);

Examples
Use without address:
wpi_connection_v1('COM3');

Use without address:
wpi_connection_v1('COM3', 28);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Reset syringe pump to factory:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Resets pump back to factory settings removing address or any set values such as diameter, rate volume all to 0. 

Function: wpi_reset_v1.m
Generic use:
wpi_reset_v1(CONNECTED_PUMP); 

Example:
wpi_reset_v1(pump)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Set syringe pump address:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
The input address needs to be correct for this function to work, if unsure of the address prior to connecting the pump please 
hold down the setup key and look for the code 'Ad:NN' where the NN will be numerical and be the address the pump is currently set to.    

Function: wpi_set_address_v1.m
Generic use:
wpi_set_address_v1(CONNECTED_PUMP, CURRENT_ADDRESS, NEW_ADDRESS); 

Examples:
Changes address from '00' to '28'
wpi_set_address_v1(pump, 00, 28);

Changes address from '28' to '00'
wpi_set_address_v1(pump, 28, 00);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Start or stop syringe pump:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Function to start or stop the syringe pump from pumping. Input of 'start' will start the pump, whereas input of 'stop' will stop the pump. 

Function: wpi_start_stop_v1.m
Generic use:
wpi_start_stop_v1(CONNECTED_PUMP, STATE, ADDRESS); 

Examples:
Starts a pump at address '00'
wpi_start_stop_v1(pump, 'start');

Starts a pump at address '28'
wpi_start_stop_v1(pump, 'start', 28);

Stops a pump at address '00'
wpi_start_stop_v1(pump, 'stop');

Stops a pump at address '28'
wpi_start_stop_v1(pump, 'stop', 28);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Set syringe diameter:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sets the diameter of the syringe for the pump. This function is built for Aladdin 4000 pumps with a maximum syringe diameter of 30 mm (60 mL syringe),
so if using a larger syringe warnings about settings can be ignored. This value is always in mm, and for diameters below 14 the volume is set to uL for 
diameters above the volume is set to mL, this is a setting built into the pump and cannot be changed. 

Function: wpi_set_diam_v1.m
Generic use:
wpi_set_diam_v1(CONNECTED_PUMP, VALUE, ADDRESS); 

Examples:
Read current diameter set on pump with address '00'
wpi_set_diam_v1(pump, 'read');

Read current diameter set on pump with address '28'
wpi_set_diam_v1(pump, 'read', 28);

Set diameter to 10 mm for pump with address '00'
wpi_set_diam_v1(pump, 10);

Set diameter to 10 mm for pump with address '28'
wpi_set_diam_v1(pump, 10, 28);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Set direction for the pump:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sets the direction of the pump. Withdraw means the syringe is sucking the solution into the syringe, infuse means the syringe is injecting solution out of it. 

Function: wpi_set_direction_v1.m
Generic use:
wpi_set_direction_v1(CONNECTED_PUMP, STATE, ADDRESS); 

Examples:
Read current direction set on pump with address '00'
wpi_set_direction_v1(pump, 'read');

Read current direction set on pump with address '28'
wpi_set_direction_v1(pump, 'read', 28);

Set direction to withdraw for pump with address '00'
wpi_set_direction_v1(pump, 'withdraw');

Set direction to withdraw for pump with address '28'
wpi_set_direction_v1(pump, 'withdraw', 28);

Set direction to infuse for pump with address '00'
wpi_set_direction_v1(pump, 'infuse');

Set direction to infuse for pump with address '28'
wpi_set_direction_v1(pump, infuse', 28);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Set rate and rate units for the pump:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sets the rate at which the pump is pumping as well as the units. If no unit is included, they are automatically set based off the syringe diameter set. Syringes with a diameter less than 14 mm will pump at uL per minute, and above 14 mm will pump at mL per minute. To stop this put in the unit you wish to pump at using the unit characters below:
'mLh' - mL per hour 
'mLm' - mL per minute 
'uLh' - uL per hour
'uLm' - uL per minute 

Function: wpi_set_rate_v1.m
Generic use:
wpi_set_rate_v1(CONNECTED_PUMP, VALUE, UNIT, ADDRESS); 

Examples:
Read current rate set on pump with address '00'
wpi_set_rate_v1(pump, 'read');

Read current rate set on pump with address '28'
wpi_set_rate_v1(pump, 'read', '', 28);

set current rate to 10 on pump with address '00' - units will be set as explained above
wpi_set_rate_v1(pump, 10);

set current rate to 10 on pump with address '28'  - units will be set as explained above
wpi_set_rate_v1(pump, 10, '', 28);

set current rate to 10 mL per min on pump with address '00'
wpi_set_rate_v1(pump, 10, 'mLm');

set current rate to 10 mL per min on pump with address '28'
wpi_set_rate_v1(pump, 10, 'mLm', 28);

set current rate to 10 mL per hour on pump with address '00'
wpi_set_rate_v1(pump, 10, 'mLh');

set current rate to 10 mL per hour on pump with address '28'
wpi_set_rate_v1(pump, 10, 'mLh', 28);

set current rate to 10 uL per min on pump with address '00'
wpi_set_rate_v1(pump, 10, 'uLm');

set current rate to 10 uL per min on pump with address '28'
wpi_set_rate_v1(pump, 10, 'uLm', 28);

set current rate to 10 uL per hour on pump with address '00'
wpi_set_rate_v1(pump, 10, 'uLh');

set current rate to 10 uL per hour on pump with address '28'
wpi_set_rate_v1(pump, 10, 'uLh', 28);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Set pump volume:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sets the volume which the pump will withdraw or inject. Units for this are extracted from the diameter of the syringe, syringes with a diameter less than 14 mm will only allow for uL to be set, whilst for syringes with a diameter above 14 mm mL will be automatically set. 

Function: wpi_set_volume_v1.m
Generic use:
wpi_set_volume_v1(CONNECTED_PUMP, VALUE, ADDRESS); 

Examples:
Read current volume set on pump with address '00'
wpi_set_volume_v1(pump, 'read');

Read current volume set on pump with address '28'
wpi_set_volume_v1(pump, 'read', 28);

Set volume on pump to 10 with address '00'
wpi_set_volume_v1(pump, 10);

Set volume on pump to 10 with address '28'
wpi_set_volume_v1(pump, 10, 28);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dispensed volume from pump:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Reads or clears the volume dispensed from the pump depending on the input. To read from the pump the input should be 'read' to reset the volumes dispensed the input should be 'clear' see below for further examples. 

Function: wpi_volume_dis_v1.m
Generic use:
wpi_volume_dis_v1(CONNECTED_PUMP, STATE, ADDRESS); 

Examples:
Read volume currently dispensed by pump with address '00'
wpi_volume_dis_v1(pump, 'read');

Read current volume dispensed on pump with address '28'
wpi_volume_dis_v1(pump, 'read', 28);

Clear volume dispensed on pump with address '00'
wpi_set_volume_v1(pump, 'clear');

Clear volume dispensed with address '28'
wpi_set_volume_v1(pump, 'clear', 28);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Change flow rate whilst pump is pumping:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Changes the flow rate of the pump whilst pumping

Function: wpi_change_rate_v1.m
Generic use:
wpi_change_rate_v1(CONNECTED_PUMP, value, ADDRESS); 

Examples:
Change flow rate currently on pump whilst the pump is running with address '00' to 4 mL min^-1
wpi_volume_dis_v1(pump, 4);

Change flow rate currently on pump whilst the pump is running with address '28' to 4 mL min^-1
wpi_volume_dis_v1(pump, 4, 28);

















  















