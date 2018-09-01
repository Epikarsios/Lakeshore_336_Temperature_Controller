
Fullpath = mfilename('fullpath');
[This_File_Path, This_File_Name, This_File_Extension ] = fileparts(Fullpath);
addpath(genpath(This_File_Path));





Lakeshore_Connection = Lakeshore_Temperature_Controller_Create( );
VQM_Connection       = VQM_Serial_Create();
Lakeshore  = Lakeshore_336_Temperature_Controller();
VQM        = Granville_Phillips_835_VQM();
fopen(Lakeshore_Connection);
fopen(VQM_Connection);
Get_Serial_Obj(Lakeshore, Lakeshore_Connection);
Update_Data(Lakeshore, Lakeshore_Connection);

Time = [];
Temperature_A = [];
[ Time_Stamp, Epoch_Time ] = Get_Date_Time( );
Time = [Time, Epoch_Time];
Temperature_A = [Temperature_A, str2double(Lakeshore.A_Current_Temperature)];
Pressure = [];
 Get_Total_Pressure(VQM, VQM_Connection)
Pressure = [Pressure, VQM.Current_Pressure];
figure
subplot(2,1,1)
h = plot(Time, Temperature_A);
grid on
datacursormode on
xlabel('Time')
ylabel('Temperature')

subplot(2,1,2)
j = semilogy(Time, Pressure);
grid on
xlabel('Time')
ylabel('Pressure')

for i = 1:20
   Add_Log_Data(Lakeshore);
   h.XDataSource = 'Time';
   h.YDataSource = 'Temperature_A' ;
   Update_Data(Lakeshore, Lakeshore_Connection);
   [ Time_Stamp, Epoch_Time ] = Get_Date_Time( );
   Time = [Time, Epoch_Time];
   Temperature_A = [Temperature_A, str2double(Lakeshore.A_Current_Temperature)];
   refreshdata(h)
 
   Add_Log_Data(VQM)
   j.XDataSource = 'Time';
   j.YDataSource = 'Pressure';
   Get_Total_Pressure(VQM, VQM_Connection);
   Pressure = [Pressure, VQM.Current_Pressure ];
   refreshdata(j)
  pause(1);
end

[Log_Filename, Log_Filepath] = uiputfile('.txt', 'Choose Location and Filename');
            


CSV_Data = table(Lakeshore.A_Temperature_Log(:), Lakeshore.C_Temperature_Log(:) , Lakeshore.Setpoint_1_Log(:), Lakeshore.Setpoint_2_Log(:), VQM.Log_Pressure(:));
CSV_Data.Properties.VariableNames = {'Temperature_A', 'Temperature_C', 'Setpoint_1', 'Setpoint_2', 'Log_Pressure'};   
writetable(CSV_Data, Log_Filename, 'Delimiter', '\t')
%Log_File_Create(Lakeshore);

%Write_Log_Data(Lakeshore);

Close_Stray_Serial_Objects( );

