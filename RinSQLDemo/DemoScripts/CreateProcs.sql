IF EXISTS ( 
	SELECT  * FROM sys.objects
    WHERE   object_id = OBJECT_ID(N'[demo].[sp_TrainRegModelDemo]')
    AND type IN ( N'P', N'PC' )
) DROP PROC demo.sp_TrainRegModelDemo;
GO

CREATE PROC demo.sp_TrainRegModelDemo
AS
BEGIN

DECLARE @model varbinary(max);
  
EXEC sp_execute_external_script  
	 @language = N'R' 
	  
-- Begin Learn Model Script
	,@script = 
N'    
	model <- lm(Output ~ Input, data = inputData);
	print(summary(model))    
    modelbin <- serialize(model, NULL);  
'  
-- End Learn Model Script
 
	, @input_data_1 = 
N'  
	SELECT 
		Input,
		Output
	FROM 
		demo.Data; 
'  
      , @input_data_1_name = N'inputData'  
      , @params = N'@modelbin varbinary(max) OUTPUT'  
      , @modelbin = @model OUTPUT;


INSERT INTO demo.Models (Name,Model,ModifiedDate)
SELECT 'regModel-demo-v1',@model,GETDATE()

END
GO


EXEC demo.sp_TrainRegModelDemo;

SELECT * FROM demo.models;




