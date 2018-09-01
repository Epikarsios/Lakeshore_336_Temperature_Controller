function [ Setpoint ] = Set_Temperature_Setpoint( Serial_Obj, Output,Temperature_Value)
%Set_Temperature_Setpoint Set the Heater Setpoint Heater A(Output1) and Heater C(Output 2)

%   
Command = 'SETP ';
Output = num2str(Output);
Temperature_Value = num2str(Temperature_Value);
Command = [Command,Output,',',Temperature_Value];
fprintf(Serial_Obj, Command);
pause(0.07)
Setpoint = Get_Temperature_Setpoint(Serial_Obj);
end

