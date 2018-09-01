function [ Data, Data_String ] = Get_Heater_Range( Serial_Obj )
% Returns the Heater Range as for each input as a string and number
%   
Data.A = query(Serial_Obj, 'RANGE? 1');
Data.C = query(Serial_Obj, 'RANGE? 2');

if str2double(Data.A) == 0;
    Data_String.A = 'Off';
elseif str2double(Data.A) == 1;
    Data_String.A = 'Low';
elseif str2double(Data.A) == 2;
    Data_String.A = 'Medium';
elseif str2double(Data.A) == 3;
    Data_String.A = 'High';
end
if str2double(Data.C) == 0;
    Data_String.C = 'Off';
elseif str2double(Data.C) == 1;
    Data_String.C = 'Low';
    elseif str2double(Data.C) == 2;
    Data_String.C = 'Medium';
elseif str2double(Data.C) == 3;
    Data_String.C = 'High';
end

end

