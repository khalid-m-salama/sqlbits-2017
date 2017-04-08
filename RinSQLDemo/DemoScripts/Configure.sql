Exec sp_configure  'external scripts enabled', 1  
Reconfigure  with override;   

Exec sp_configure  'external scripts enabled';

-- strart LaunchPad services if stopped

exec sp_execute_external_script  @language =N'R',  
@script=N'OutputDataSet<-InputDataSet',    
@input_data_1 =N'select 1 as hello'  
with result sets (([hello] int not null));  
go


USE sqlbitsdemo 
GO  
GRANT EXECUTE ANY EXTERNAL SCRIPT  TO [UserName]  