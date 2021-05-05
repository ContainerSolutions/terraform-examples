# Index of features

| Feature                 | Links          |
| -------------           |:-------------:|
| `aws_instance`          | [aws](aws/aws_instance) <p/> [simple](aws/aws_instance/simple) |
| `aws_security_group`    | [aws, ssh](aws/aws_security_group/ssh) <p/> [aws, open](aws/aws_security_group/open) |
| `aws_vpc`               | [aws](aws/aws_vpc/simple) |
| `count`                 | [aws, aws_instance](aws/aws_instance/count) <p/> [aws, aws_vpc](aws/aws_vpc/count) |
| `for`                   | [aws, aws_vpc](aws/aws_vpc/for) |
| `for_each`              | [map, local](local/null_resource/for_each) <p/> [aws](aws/aws_instance/for_each) |
| `inline`                | [aws, remote_exec](aws/aws_instance/remote-exec/inline/) |
| `local_file`            | [local](local/local_file/hello) <p/> [local](local/local_file/preexisting_file) |
| `map`                   | [null_resource, for_each, local](local/null_resource/for_each) |
| `module`                | [local, module usage](variables/local_file/module) <p/> [local, module example](modules/local_file/hello_module) <p/> [local, module example consumer](modules/local_file/hello_consumer) |
| `null_resource`         | [simple, local](local/null_resource/simple) |
| `outputs`               | [local](outputs/local_file/local_file) <p/> [local, module](outputs/local_file/module) |
| `random_id`             | [simple](aws/aws_s3_bucket/simple) |
| `remote-exec`           | [aws, inline](aws/aws_instance/remote-exec/inline) |
| `splat`                 | [aws, aws_vpc](aws/aws_vpc/splat) |
| `variable`              | [aws, local_file](variables/local_file/local_file) |
| `kubernetes_namespace`  | [simple](kubernetes/kubernetes_namespace/simple) |
| `kubernetes_deployment` | [simple](kubernetes/kubernetes_deployment/simple) <p/> [deployment-and-service](kubernetes/kubernetes_deployment/deployment-and-service) |
| `kubernetes_service`    | [simple](kubernetes/kubernetes_service/simple) |
| `kubernetes_config_map` | [simple](kubernetes/kubernetes_config_map/simple) <p/> [data_from_files](kubernetes/kubernetes_config_map/from_files) |
