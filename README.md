# better-sqlite3 Lambda Layer

A [layer for AWS Lambda](https://aws.amazon.com/about-aws/whats-new/2018/11/aws-lambda-now-supports-custom-runtimes-and-layers/) 
that allows you to use [better-sqlite3](https://github.com/JoshuaWise/better-sqlite3) without having to compile any native modules. Just include this layer and then your code can access `better-sqlite3` normally when running in AWS Lambda.

It also serves as a template and example for using any native-compiled module with a nodejs lambda.

## Usage

When configuring your lambda, click on Layers and choose "Add a layer". Choose "Provide a layer version ARN" and use the following ARN (latest version - [see all versions](#version-arns)):

    arn:aws:lambda:us-east-1:284387765956:layer:BetterSqlite3:9

Then, in your code, simply require and use better-sqlite3 as you normally would:

    const db = require('better-sqlite3')('myDatabase.db', {options});

See the [example](example/README.md).

## Hosting This In Your Own Account

Clone this repo:

    git clone git@github.com:seanfisher/better-sqlite3-lambda-layer.git

You can use the build script to build the layer directory:

    RUNTIME=nodejs12 ./build.sh
    RUNTIME=nodejs14 ./build.sh
    RUNTIME=nodejs16 ./build.sh

Then use [serverless](https://serverless.com/framework/docs/providers/aws/guide/functions/#layers) to deploy the layer and example function to your own account:


    RUNTIME=nodejs14 ./build.sh sls deploy

To build and deploy in one step:

    npm run deploy12
    npm run deploy14
    npm run deploy16

It should spit out the name of the ARN that you can use in your other lambdas.

If you want to use a lambda globally, you can run this command to grant access globally (replace $VERSION with the correct version):

    aws lambda add-layer-version-permission --layer-name BetterSqlite3 --statement-id global-lambda-layer-access --version-number $VERSION --principal '*' --action lambda:GetLayerVersion

## Customization

This repo should also work with other native modules - just build your application normally using `npm install`. You can even run your application locally; the build script takes your entire `node_modules` folder, installs the production dependencies built using a lambda environment, and packages it up into the layer.

Since currently all the production `node_modules` are included in the layer, they are excluded from the serverless deployment package.

## Version ARNs

| node.js version | better-sqlite3 version | ARN                                                                    |
|-----------------| --- |------------------------------------------------------------------------|
| 12.x            | 5.4.0 | arn:aws:lambda:us-east-1:284387765956:layer:BetterSqlite3:8            |
| 12.x            | 6.0.1 | arn:aws:lambda:us-east-1:284387765956:layer:BetterSqlite3:9            |
| 12.x            | 6.0.1 | arn:aws:lambda:us-east-1:833069544670:layer:better-sqlite3-nodejs12:1  |
| 14.x            | 6.0.1 | arn:aws:lambda:us-east-1:833069544670:layer:better-sqlite3-nodejs14:1  |
| 16.x            | 7.6.2 | arn:aws:lambda:us-east-1:833069544670:layer:better-sqlite3-nodejs16:1  |