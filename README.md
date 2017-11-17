# Read Me

The problem: an individual would like to use a Docker image stored on
Amazon Web Services (AWS), but does not have any tools other than
Docker, and therefore cannot authenticate on the command-line with AWS.

This Docker image will authenticate the user with Amazon's EC2 Container
Registry (ECR), allowing them to download private images from AWS using
just Docker.

Equipped with the individual's AWS access and secret-access keys, you
may run the following command directly (replace the env values as
necessary).

    docker run --rm \
        --env AWS_ACCESS_KEY_ID=AKIAIO5FODNN7EXAMPLE \
        --env AWS_REGION=us-east-2 \
        --env AWS_SECRET_ACCESS_KEY=c2L7yXeGvUyrPgYsDnWRRC1AYEXAMPLE \
        jambonrose/ecr-login

This will output the command that you can copy and paste into your
terminal to login to ECR. Alternatively, you can call the output of the
command directly. In bash you would wrap the command above in backticks
or `$( )`, as shown below.

    $(docker run --rm \
        --env AWS_ACCESS_KEY_ID=AKIAIO5FODNN7EXAMPLE \
        --env AWS_REGION=us-east-2 \
        --env AWS_SECRET_ACCESS_KEY=c2L7yXeGvUyrPgYsDnWRRC1AYEXAMPLE \
        jambonrose/ecr-login)

On Windows, you would use the `Invoke-Expression` command.

    Invoke-Expression -Command (docker run --rm \
        --env AWS_ACCESS_KEY_ID=AKIAIO5FODNN7EXAMPLE \
        --env AWS_REGION=us-east-2 \
        --env AWS_SECRET_ACCESS_KEY=c2L7yXeGvUyrPgYsDnWRRC1AYEXAMPLE \
        jambonrose/ecr-login)

If you or the individual don't feel like specifying the variables as
each run, you may create a file with these credentials to avoid having
to retype them constantly. For example, I will create a file named
`.env` and write the following to the file.

    AWS_ACCESS_KEY_ID=AKIAIO5FODNN7EXAMPLE
    AWS_REGION=us-east-2
    AWS_SECRET_ACCESS_KEY=c2L7yXeGvUyrPgYsDnWRRC1AYEXAMPLE

This then allows bash users to use the command below to log in to ECR
automagically.

    $(docker run --rm --env-file .env jambonrose/ecr-login)

Windows users would use the command below.

    Invoke-Expression -Command (docker run --rm \
        --env-file .env jambonrose/ecr-login)
