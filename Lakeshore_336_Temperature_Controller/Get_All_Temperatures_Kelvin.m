function [ Data ] = Get_All_Temperatures_Kelvin( Serial_Obj )
% Gets the temperture reading from the Lakeshore 336 in kelvin
%   Detailed explanation goes here


Data.A = query(Serial_Obj,'KRDG? A');
Data.C = query(Serial_Obj,'KRDG? C');

end

