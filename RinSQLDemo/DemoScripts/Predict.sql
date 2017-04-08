DECLARE @input_in FLOAT = 10;
DECLARE @model_in VARBINARY(MAX);

SELECT 
	@model_in = Model
FROM 
	demo.Models
WHERE 
	ModifiedDate IN (Select MAX(ModifiedDate) FROM demo.Models);

EXEC sp_execute_external_script  
	 @language = N'R'  
	,@script = 

-- Begin Predict
N'
    mod <- unserialize(as.raw(model));	
	output <- predict(mod, InputDataSet); 
	
	InputDataSet$output = output
	data_output = InputDataSet
    
	print(data_output)    
'  
-- End Predict
    
  ,@input_data_1 = N'SELECT @Input AS Input;'
  --,@input_data_1 = N'SELECT TOP 5 Input FROM demo.Data;'
  ,@output_data_1_name = N'data_output'
  ,@params = N'@model varbinary(max),
               @input float'
			   ,@model = @model_in 
			   ,@input = @input_in
   WITH RESULT SETS (([Input] FLOAT, [Output] FLOAT));




   

