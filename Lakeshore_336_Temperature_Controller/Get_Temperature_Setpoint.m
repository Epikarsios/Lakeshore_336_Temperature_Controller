function [ Setpoint ] = Get_Temperature_Setpoint( Serial_Obj )
%Get_Temperature_Setpoint Returns Temperature Setpoint for Heater A(Output1) and Heater C(Output 2)


Setpoint.A = query(Serial_Obj, 'SETP? 1');
Setpoint.C = query(Serial_Obj, 'SETP? 2');


end

