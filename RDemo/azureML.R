#install.packages("AzureML")

rm(list = ls(all = TRUE))

library(AzureML)

# list AzureML functions
ls("package:AzureML")

# connec to your Azure ML workspace
ws <- workspace(id = "<your workspace Id>",
auth = "<your authorization token>",
api_endpoint = "https://europewest.studio.azureml.net",
management_endpoint = "https://europewest.management.azureml.net")

# list the experiements in your workspace
head(experiments(ws))

# load a data frame
data_file = "data/reg-data.csv"
data = read.csv(data_file, header = TRUE)
head(data)

# build a linear reg. model and show its summary
model = lm(output ~ input, data = data)
summary(model)

# create a prediction function
predictOutput = function(input_data) {
    
    output_data = predict(model, input_data)
    return(output_data)
}

# test the prediction function
intput_data = data.frame(input = c(20, 30))
predictOutput(intput_data)

# publish the prediciton function on Azure ML as a Web API
api <- publishWebService(ws, 
                         fun = predictOutput,
                         name = "aml-predictOutput",
                         inputSchema = intput_data
)

# get the API info
api

# consume the deployed API
consume(api, data.frame(input = c(10)))



