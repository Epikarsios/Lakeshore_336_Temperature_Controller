function [ Time_Stamp, Epoch_Time ] = Get_Date_Time( )
%Get_Date_Time  Function returns the current date/timestampa and Epoch time 
%   Detailed explanation goes here

Time_Stamp = datetime;
Epoch_Time = datenum(Time_Stamp);

end

