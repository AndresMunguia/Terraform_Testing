resource "aws_lambda_function" "main" {
  function_name = "ServerlessExample_Node"

  # "main" is the filename within the zip file (main.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  filename = "main.zip"
  handler = "main.handler"
  runtime = "nodejs16.x"

  role = "${aws_iam_role.lambda_exec.arn}"
}

resource "aws_lambda_function" "main_py" {
  function_name = "ServerlessExample_Python"

  # "main" is the filename within the zip file (main.js) and "handler"
  # is the name of the property under which the handler function was
  # exported in that file.
  filename = "main_py.zip"
  handler = "main_py.handler"
  runtime = "nodejs16.x"

  role = "${aws_iam_role.lambda_exec.arn}"
}

# IAM role which dictates what other AWS services the Lambda function
# may access.
resource "aws_iam_role" "lambda_exec" {
  name = "serverless_example_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.main.id}"
  parent_id   = "${aws_api_gateway_rest_api.main.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = "${aws_api_gateway_rest_api.main.id}"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  http_method   = "ANY"
  authorization = "NONE"
}

resource "aws_api_gateway_resource" "proxy_py" {
  rest_api_id = "${aws_api_gateway_rest_api.main_py.id}"
  parent_id   = "${aws_api_gateway_rest_api.main_py.root_resource_id}"
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_py" {
  rest_api_id   = "${aws_api_gateway_rest_api.main_py.id}"
  resource_id   = "${aws_api_gateway_resource.proxy_py.id}"
  http_method   = "ANY"
  authorization = "NONE"
}