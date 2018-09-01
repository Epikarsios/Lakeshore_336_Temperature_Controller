function [ Lakeshore_Serial_Obj ] = Lakeshore_Temperature_Controller_Create( )
%Lakeshore_Temperature_Controller_Create  Creates  and configures Temperature controller
%serial object
% 


Lakeshore_Serial_Obj = serial('COM3');
Lakeshore_Serial_Obj.BaudRate = 57600;
Lakeshore_Serial_Obj.Parity = 'odd';
Lakeshore_Serial_Obj.DataBits = 7;


end

