function Close_Stray_Serial_Objects( )
%  Close_Stray_Serial_Objects
%  

Serial_Objects = instrfindall;
if isempty(Serial_Objects)
    return;
else
    for idx = length(Serial_Objects);
        if  strcmp(Serial_Objects(idx).status,'open');
            fclose(instrfindall);
            delete(instrfindall);
            
        else
            delete(instrfindall);
        
        end
    end
end

