output "base_url_node" {
  value = aws_api_gateway_deployment.main.invoke_url
}

output "base_url_py" {
  value = aws_api_gateway_deployment.main_py.invoke_url
}