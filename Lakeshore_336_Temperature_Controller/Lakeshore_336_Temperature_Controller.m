classdef Lakeshore_336_Temperature_Controller < handle
    %   Lakeshore_336_Temperature_Controller 
    %   This is an  class for the Lakeshore 336 Temperature Controller
    %   This class contains functions for sending commands and calling data
    %   as well as storing the data.
  
    
    properties
       
       % There are four temperature readings A-D  
        A_Current_Temperature;
        B_Current_Temperature;
        C_Current_Temperature;
        D_Current_Temperature;
      %  a ='off';
       % There are two heaters:  Input 1 for A, and input 2 for C
       % There are four levels coresponding to a number
       % 0 = Off, 1 = Low, 2 = Medium, 3 = High.
        Input_1_Heater_Range;
        Input_2_Heater_Range;
        
        Input_1_Heater_Range_Str;
        Input_2_Heater_Range_Str;
        
        % Temperature Setpoint: 1 = A, 2 = C.
        Setpoint_1;
        Setpoint_2;
        Serial_Object;
        
        % Log Data
        A_Temperature_Log;
        B_Temperature_Log;
        C_Temperature_Log;
        D_Temperature_Log;
        
        Input_1_Heater_Range_Log;
        Input_2_Heater_Range_Log;
        
        Input_1_Heater_Range_Str_Log;
        Input_2_Heater_Range_Str_Log;
        
        % Temperature Setpoint: 1 = A, 2 = C.
        Setpoint_1_Log;
        Setpoint_2_Log;
        
        % Log Administration
        
        Log_Filename;
        Log_Filepath;
        Log_File_Extension;
        CSV_Data = table;
        
    end
    
    
    
    methods
        
   

        function Get_All_Temperatures_Kelvin(obj)
            obj.A_Current_Temperature = query(obj.Serial_Object,'KRDG? A');
            obj.B_Current_Temperature = query(obj.Serial_Object,'KRDG? B');
            obj.C_Current_Temperature = query(obj.Serial_Object,'KRDG? C');
            obj.D_Current_Temperature = query(obj.Serial_Object,'KRDG? D');
        
        end
        
        %Get_Temperature_Setpoint Returns Temperature Setpoint for Heater A(Output1) and Heater C(Output 2)
        function Get_Temperature_Setpoint(obj, Serial_Obj )
            obj.Setpoint_1 = query(Serial_Obj, 'SETP? 1');
            obj.Setpoint_2 = query(Serial_Obj, 'SETP? 2');
        end
       
        
        
        
        function  Get_Heater_Range( obj,Serial_Obj )   
            obj.Input_1_Heater_Range = query(Serial_Obj, 'RANGE? 1');
            obj.Input_2_Heater_Range = query(Serial_Obj, 'RANGE? 2');
            if str2double(obj.Input_1_Heater_Range) == 0;
                obj.Input_1_Heater_Range_Str = 'Off';
            elseif str2double(obj.Input_1_Heater_Range) == 1;
                obj.Input_1_Heater_Range_Str = 'Low';
            elseif str2double(obj.Input_1_Heater_Range) == 2;
                obj.Input_1_Heater_Range_Str = 'Medium';
            elseif str2double(obj.Input_1_Heater_Range) == 3;
                obj.Input_1_Heater_Range_Str = 'High';
            end
            if str2double(obj.Input_2_Heater_Range) == 0;
                obj.Input_2_Heater_Range_Str = 'Off';
            elseif str2double(obj.Input_2_Heater_Range) == 1;
                obj.Input_2_Heater_Range_Str = 'Low';
            elseif str2double(obj.Input_2_Heater_Range) == 2;
                obj.Input_2_Heater_Range_Str = 'Medium';
            elseif str2double(obj.Input_2_Heater_Range) == 3;
                obj.Input_2_Heater_Range_Str = 'High';
            end


        end


       function Update_Data(obj,Serial_Obj)
            
            obj.Get_All_Temperatures_Kelvin(    );
            obj.Get_Heater_Range(Serial_Obj);
            obj.Get_Temperature_Setpoint(Serial_Obj)
       end 
        
       function Add_Log_Data(obj)
          % disp('Add Log Data')
            %obj.A_Temperature_Log{end+1} = obj.A_Current_Temperature
            obj.A_Temperature_Log{end+1} = str2double(obj.A_Current_Temperature);
            obj.B_Temperature_Log{end+1} = str2double(obj.B_Current_Temperature);
            obj.C_Temperature_Log{end+1} = str2double(obj.C_Current_Temperature);
            obj.D_Temperature_Log{end+1} = str2double(obj.D_Current_Temperature);
        
            obj.Input_1_Heater_Range_Log{end+1} = str2double(obj.Input_1_Heater_Range);
            obj.Input_2_Heater_Range_Log{end+1} = str2double(obj.Input_2_Heater_Range);
        
            obj.Input_1_Heater_Range_Str_Log{end+1} = obj.Input_1_Heater_Range_Str;
            obj.Input_2_Heater_Range_Str_Log{end+1} = obj.Input_2_Heater_Range_Str;
        
        % Temperature Setpoint: 1 = A, 2 = C.
            obj.Setpoint_1_Log{end+1} = str2double(obj.Setpoint_1);
            obj.Setpoint_2_Log{end+1} = str2double(obj.Setpoint_2);
       end
        
       
       function Write_Log_Data(obj)
           %disp('Write Log!!') 
            obj.A_Temperature_Log = obj.A_Temperature_Log(:);
            disp(obj.A_Temperature_Log)
            obj.B_Temperature_Log = obj.B_Temperature_Log(:);
            obj.C_Temperature_Log = obj.C_Temperature_Log(:);
            obj.D_Temperature_Log = obj.D_Temperature_Log(:);
        
            obj.Input_1_Heater_Range_Log = obj.Input_1_Heater_Range_Log(:);
            obj.Input_2_Heater_Range_Log = obj.Input_2_Heater_Range_Log(:);
        
            obj.Input_1_Heater_Range_Str_Log = obj.Input_1_Heater_Range_Str_Log(:);
            obj.Input_2_Heater_Range_Str_Log = obj.Input_2_Heater_Range_Str_Log(:);
        
        % Temperature Setpoint: 1 = A, 2 = C.
            obj.Setpoint_1_Log = obj.Setpoint_1_Log(:);
            obj.Setpoint_2_Log = obj.Setpoint_2_Log(:);
           
           obj.CSV_Data = table(obj.A_Temperature_Log,obj.C_Temperature_Log , obj.Setpoint_1_Log,obj.Setpoint_2_Log);
           obj.CSV_Data.Properties.VariableNames = {'Temperature_A', 'Temperature_C', 'Setpoint_1', 'Setpoint_2'};   
           writetable(obj.CSV_Data, obj.Log_Filename, 'Delimiter', '\t')
          % writetable(obj.CSV_Data, 'myTable.txt', 'Delimiter', ' ');
           % writetable(obj.CSV_Data);
           
           
           
       end
       
       function Log_File_Create(obj)
            %UNTITLED Summary of this function goes here
            %   Detailed explanation goes here

            [obj.Log_Filename, obj.Log_Filepath] = uiputfile('.txt', 'Choose Location and Filename');
            

end
       
       
       
       
       function Get_Serial_Obj(obj,Serial_Obj)
       obj.Serial_Object = Serial_Obj;
       end
      

    end
    
end

