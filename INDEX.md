# Index of features

| Feature                  | Links          |
| -------------            |:-------------:|
| `aws_instance`           | [aws](aws/aws_instance) <p/> [simple](aws/aws_instance/simple) |
| `aws_security_group`     | [aws, ssh](aws/aws_security_group/ssh) <p/> [aws, open](aws/aws_security_group/open) |
| `aws_s3_bucket`          | [aws, backends, s3](backends/s3/aws_s3_bucket) |
| `aws_vpc`                | [aws](aws/aws_vpc/simple) |
| `backends`               | [aws, s3, aws_s3_bucket](backends/s3/aws_s3_bucket) |
| `count`                  | [aws, aws_instance](aws/aws_instance/count) <p/> [aws, aws_vpc](aws/aws_vpc/count) |
| `for`                    | [aws, aws_vpc](aws/aws_vpc/for) |
| `for_each`               | [map, local](local/null_resource/for_each) <p/> [aws](aws/aws_instance/for_each) |
| `google_compute_network` | [google](google/google_compute_network/simple) |
| `google_container_cluster` | [google, GKE](google/google_container_cluster/simple) <p/> [separate-node-pool](google/google_container_cluster/separate-node-pool) |
| `helm_release`           | [simple](helm/helm_release/simple) <p/> [values_from_file](helm/helm_release/values_from_file) |
| `inline`                 | [aws, remote-exec](aws/aws_instance/remote-exec/inline/) |
| `kubernetes_config_map`  | [simple](kubernetes/kubernetes_config_map/simple) <p/> [data_from_files](kubernetes/kubernetes_config_map/from_files) |
| `kubernetes_deployment`  | [simple](kubernetes/kubernetes_deployment/simple) <p/> [deployment-and-service](kubernetes/kubernetes_deployment/deployment-and-service) |
| `kubernetes_namespace`   | [simple](kubernetes/kubernetes_namespace/simple) |
| `kubernetes_service`     | [simple](kubernetes/kubernetes_service/simple) |
| `local_file`             | [local](local/local_file/hello) <p/> [local](local/local_file/preexisting_file) |
| `map`                    | [null_resource, for_each, local](local/null_resource/for_each) |
| `module`                 | [local, module usage](variables/local_file/module) <p/> [local, module example](modules/local_file/hello_module) <p/> [local, module example consumer](modules/local_file/hello_consumer) |
| `null_resource`          | [simple, local](local/null_resource/simple) |
| `outputs`                | [local](outputs/local_file/local_file) <p/> [local, module](outputs/local_file/module) |
| `random_id`              | [simple](aws/aws_s3_bucket/simple) |
| `remote-exec`            | [aws, inline](aws/aws_instance/remote-exec/inline) |
| `splat`                  | [aws, aws_vpc](aws/aws_vpc/splat) |
| `s3`                     | [aws, backends, aws_s3_bucket](backends/s3/aws_s3_bucket) |
| `variable`               | [aws, local_file](variables/local_file/local_file) |
| `windows`                | [aws_instance, remote-exec, inline](aws/aws_instance/remote-exec/inline/windows) |
