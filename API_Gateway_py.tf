resource "aws_api_gateway_rest_api" "main_py" {
  name        = "ServerlessExample_py"
  description = "REST API pointing to Lambda written in Python."
}

resource "aws_api_gateway_integration" "lambda_py" {
  rest_api_id = aws_api_gateway_rest_api.main_py.id
  resource_id = aws_api_gateway_method.proxy_py.resource_id
  http_method = aws_api_gateway_method.proxy_py.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.main_py.invoke_arn
}

resource "aws_api_gateway_method" "proxy_root_py" {
  rest_api_id   = aws_api_gateway_rest_api.main_py.id
  resource_id   = aws_api_gateway_rest_api.main_py.root_resource_id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda_root_py" {
  rest_api_id = aws_api_gateway_rest_api.main_py.id
  resource_id = aws_api_gateway_method.proxy_root_py.resource_id
  http_method = aws_api_gateway_method.proxy_root_py.http_method

  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.main_py.invoke_arn
}

resource "aws_api_gateway_deployment" "main_py" {
  depends_on = [
    "aws_api_gateway_integration.lambda_py",
    "aws_api_gateway_integration.lambda_root_py",
  ]

  rest_api_id = aws_api_gateway_rest_api.main_py.id
  stage_name  = "birthDate"
}

resource "aws_lambda_permission" "apigw_py" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.main_py.function_name
  principal     = "apigateway.amazonaws.com"

  # The /*/* portion grants access from any method on any resource
  # within the API Gateway "REST API".
  source_arn = "${aws_api_gateway_rest_api.main_py.execution_arn}/*/*"
}