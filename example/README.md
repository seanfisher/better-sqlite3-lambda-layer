# Example Service using Native-Compiled Modules in AWS Lambda using Layers

This example application uses the native-compiled better-sqlite3 package using AWS Lambda Layers.

## Usage

Deploy this application with the [serverless framework](https://serverless.com/) from the parent directory (the one with the `serverless.yml`).

    cd ..
    sls deploy

Send a test event via the lambda console (it doesn't matter what the event JSON is) and you should see the example code load the included `test.db` and make a query. You should see the results returned from the lambda:

    Successfully loaded row: Sean Fisher
