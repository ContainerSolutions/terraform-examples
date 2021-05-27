# Index of features

| Feature                        | Links/Related Features  |
| -------------                  |:-------------:|
| `aws_instance`                 | [aws](aws/aws_instance) <p/> [simple](aws/aws_instance/simple) |
| `aws_security_group`           | [aws, ssh](aws/aws_security_group/ssh) <p/> [aws, open](aws/aws_security_group/open) |
| `aws_s3_bucket`                | [aws, backends, s3](backends/s3/aws_s3_bucket) |
| `aws_vpc`                      | [aws](aws/aws_vpc/simple) |
| `aws_eks`                      | [aws, spot_and_fargate](aws/aws_eks/fargate/spot_and_fargate) |
| `backends`                     | [backends](backends) <p/> [aws, s3, aws_s3_bucket](backends/s3/aws_s3_bucket) <p/> [aws, remote](backends/remote) <p/> [google, gcs_bucket](backends/gcs/google_storage_bucket) |
| `count`                        | [aws, aws_instance](aws/aws_instance/count) <p/> [aws, aws_vpc](aws/aws_vpc/count) <p/> [google, gcp_attached_disk](google/google_compute_attached_disk/count) |
| `dynamic`                      | [aws, aws_security_group](aws/aws_security_group/dynamic) |
| `for`                          | [aws, aws_vpc](aws/aws_vpc/for) |
| `for_each`                     | [map, local](local/null_resource/for_each) <p/> [aws](aws/aws_instance/for_each) |
| `google_compute_attached_disk` | [google](google/google_compute_attached_disk/simple) <p/> [count](google/google_compute_attached_disk/count) |
| `google_compute_disk`          | [google, gcp_disk](google/google_compute_disk/simple) |
| `google_compute_instance`      | [google, gcp_instance](google/google_compute_instance/simple) |
| `google_compute_network`       | [google](google/google_compute_network/simple) |
| `google_container_cluster`     | [google, GKE](google/google_container_cluster/simple) <p/> [separate_node_pool](google/google_container_cluster/separate_node_pool) <p/> [cluster_and_deployment](google/google_container_cluster/cluster_and_deployment) <p/> [vpc_native_cluster](google/google_container_cluster/vpc_native_cluster) |
| `google_storage_bucket`        | [google, gcs_bucket](google/google_storage_bucket/simple) |
| `helm_release`                 | [simple](helm/helm_release/simple) <p/> [values_from_file](helm/helm_release/values_from_file) |
| `inline`                       | [aws, remote-exec](aws/aws_instance/remote-exec/inline/) |
| `kubernetes`                   | [kubernetes](kubernetes) |
| `kubernetes_config_map`        | [simple](kubernetes/kubernetes_config_map/simple) <p/> [data_from_files](kubernetes/kubernetes_config_map/from_files) |
| `kubernetes_deployment`        | [simple](kubernetes/kubernetes_deployment/simple) <p/> [deployment_and_service](kubernetes/kubernetes_deployment/deployment_and_service) |
| `kubernetes_namespace`         | [simple](kubernetes/kubernetes_namespace/simple) |
| `kubernetes_service`           | [simple](kubernetes/kubernetes_service/simple) |
| `local`                        | [local](local) |
| `local_file`                   | [local](local/local_file/hello) <p/> [local](local/local_file/preexisting_file) |
| `map`                          | [null_resource, for_each, local](local/null_resource/for_each) |
| `module`                       | [modules](modules) <p/> [local, module usage](variables/local_file/module) <p/> [local, module example](modules/local_file/hello_module) <p/> [local, module example consumer](modules/local_file/hello_consumer) |
| `null_resource`                | [simple, local](local/null_resource/simple) |
| `outputs`                      | [outputs](outputs) <p/> [local](outputs/local_file/local_file) <p/> [local, module](outputs/local_file/module) |
| `outputs`                      | [local](outputs/local_file/local_file) <p/> [local, module](outputs/local_file/module) |
| `random_id`                    | [simple](aws/aws_s3_bucket/simple) |
| `remote-exec`                  | [aws, inline](aws/aws_instance/remote-exec/inline) |
| `splat`                        | [aws, aws_vpc](aws/aws_vpc/splat) |
| `s3`                           | [aws, backends, aws_s3_bucket](backends/s3/aws_s3_bucket) |
| `variable`                     | [variables](variables) <p/> [aws, local_file](variables/local_file/local_file) |
| `windows`                      | [aws_instance, remote-exec, inline](aws/aws_instance/remote-exec/inline/windows) |
