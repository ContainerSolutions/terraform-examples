# Index of features
## AWS Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [aws_rds_cluster](aws/aws_rds_cluster) | [simple](aws/aws_rds_cluster/simple) | Create an RDS Aurora MySQL 1 Cluster instance that does not inherit configuration from the cluster |
| [aws_instance](aws/aws_instance) | [count](aws/aws_instance/count) | Uses the 'count' feature to create multiple EC2 instances. |
| [aws_instance](aws/aws_instance) | [simple_ssh_access](aws/aws_instance/simple_ssh_access) | Remote execution using default expected location of your ssh keys, |
| [aws_instance](aws/aws_instance) | [remote-exec](aws/aws_instance/remote-exec) | Remote execution using default expected location of your ssh keys, |
| [aws_instance](aws/aws_instance) | [remote-exec](aws/aws_instance/remote-exec) | Run a command in a newly-created Windows machine |
| [aws_instance](aws/aws_instance) | [for_each](aws/aws_instance/for_each) | Example of 'for_each' usage. |
| [aws_instance](aws/aws_instance) | [simple](aws/aws_instance/simple) | Simplest example of an aws_instance resource |
| [aws_instance](aws/aws_instance) | [ami_lookup](aws/aws_instance/ami_lookup) | Data Source for getting latest getting AMI Linux Imagehttps://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html |
| [aws_elb](aws/aws_elb) | [network_elb](aws/aws_elb/network_elb) | Creates a simple Network Load Balancer and an ASG |
| [aws_elb](aws/aws_elb) | [classic_elb](aws/aws_elb/classic_elb) | Creates a simple Classic Elastic Load Balancer with two EC2 Instances  |
| [aws_elb](aws/aws_elb) | [application_elb](aws/aws_elb/application_elb) | Creates a simple Application Load Balancer and an ASG |
| [aws_db_instance](aws/aws_db_instance) | [postgres](aws/aws_db_instance/postgres) | Create a simple AWS RDS DB Instance with Postgresql  |
| [aws_db_instance](aws/aws_db_instance) | [simple](aws/aws_db_instance/simple) | Create a simple AWS RDS DB Instance with MySQL  |
| [aws_db_instance](aws/aws_db_instance) | [db_snapshot](aws/aws_db_instance/db_snapshot) | Create a DB Instance and take a snapshot |
| [aws_db_instance](aws/aws_db_instance) | [restore_db_from_snapshot](aws/aws_db_instance/restore_db_from_snapshot) | Create a DB Instance PROD. Takes a snapshot (latest), and with the latest snapshot,creates a new DEV Instance.  |
| [aws_security_group](aws/aws_security_group) | [open](aws/aws_security_group/open) | A completely open security group |
| [aws_security_group](aws/aws_security_group) | [dynamic](aws/aws_security_group/dynamic) | Uses 'dynamic' to create multiple 'ingress' blocks within an 'aws_security_group' resource. |
| [aws_security_group](aws/aws_security_group) | [ssh](aws/aws_security_group/ssh) | Security group that allows SSH connections |
| [aws_dynamodb_table](aws/aws_dynamodb_table) | [simple](aws/aws_dynamodb_table/simple) | Create an empty table in AWS DynamoDB |
| [aws_iam](aws/aws_iam) | [users](aws/aws_iam/users) | Create an IAM user with IAM access key to allow API requests to be made as an IAM user. |
| [aws_iam](aws/aws_iam) | [groups](aws/aws_iam/groups) | Create a two users in two groups |
| [aws_db_cluster_snapshot](aws/aws_db_cluster_snapshot) | [simple](aws/aws_db_cluster_snapshot/simple) | Create a snapshot of an RDS Aurora MySQL 1 Cluster instance |
| [aws_eks](aws/aws_eks) | [fargate](aws/aws_eks/fargate) | See README.md |
| [aws_s3_bucket](aws/aws_s3_bucket) | [simple](aws/aws_s3_bucket/simple) | Create an S3 bucket |
| [aws_docdb_cluster](aws/aws_docdb_cluster) | [simple](aws/aws_docdb_cluster/simple) | Create a DocumentDB Cluster with 3 instances |
| [aws_ebs_volume](aws/aws_ebs_volume) | [ebs_snapshot](aws/aws_ebs_volume/ebs_snapshot) | Create a Snapshot for a Given EBS Volume  |
| [aws_ebs_volume](aws/aws_ebs_volume) | [simple](aws/aws_ebs_volume/simple) | Create an EBS volume in AWS  |
| [aws_ebs_volume](aws/aws_ebs_volume) | [volume_attachment](aws/aws_ebs_volume/volume_attachment) | Create an EBS volume in AWS and attach to EC2 instance |
| [aws_route53](aws/aws_route53) | [simple](aws/aws_route53/simple) | Create a simple route53 zone and TXT record |
| [aws_vpc](aws/aws_vpc) | [count](aws/aws_vpc/count) | Example of 'for' block |
| [aws_vpc](aws/aws_vpc) | [for](aws/aws_vpc/for) | Simple example of a 'for' expression in Terraform |
| [aws_vpc](aws/aws_vpc) | [splat](aws/aws_vpc/splat) | Uses the 'count' feature to create multiple EC2 instances. |
| [aws_vpc](aws/aws_vpc) | [simple](aws/aws_vpc/simple) | Create an AWS VPC |
| [aws_lambda_function](aws/aws_lambda_function) | [simple](aws/aws_lambda_function/simple) | Create a lambda function in AWS |
| [aws_dynamodb_table_item](aws/aws_dynamodb_table_item) | [simple](aws/aws_dynamodb_table_item/simple) | Create a table with one item in AWS DynamoDB |
## AZUREAD Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [azuread_group_member](azuread/azuread_group_member) | [simple](azuread/azuread_group_member/simple) | A simple Azure Active Directory Group Member assignment |
| [azuread_application](azuread/azuread_application) | [simple](azuread/azuread_application/simple) | A simple Azure Active Directory Application |
| [azuread_group](azuread/azuread_group) | [simple](azuread/azuread_group/simple) | A simple Azure Active Directory Group |
| [azuread_service_principal](azuread/azuread_service_principal) | [simple](azuread/azuread_service_principal/simple) | A simple Azure Active Directory Service Principal |
| [azuread_user](azuread/azuread_user) | [simple](azuread/azuread_user/simple) | A simple Azure Active Directory User |
## AZURERM Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [azurerm_virtual_network](azurerm/azurerm_virtual_network) | [simple](azurerm/azurerm_virtual_network/simple) | A simple Azure Virtual Network |
| [azurerm_public_ip](azurerm/azurerm_public_ip) | [simple](azurerm/azurerm_public_ip/simple) | A simple Azure Public IP |
| [azurerm_storage_share](azurerm/azurerm_storage_share) | [simple](azurerm/azurerm_storage_share/simple) | A simple Azure Storage Share for filesystem storage |
| [azurerm_app_service_plan](azurerm/azurerm_app_service_plan) | [simple](azurerm/azurerm_app_service_plan/simple) | A simple Azure App Service Plan |
| [azurerm_linux_virtual_machine](azurerm/azurerm_linux_virtual_machine) | [simple](azurerm/azurerm_linux_virtual_machine/simple) | A simple Azure Linux Virtual Machine |
| [azurerm_mssql_server](azurerm/azurerm_mssql_server) | [simple](azurerm/azurerm_mssql_server/simple) | A simple Azure MSSQL Server |
| [azurerm_dns_zone](azurerm/azurerm_dns_zone) | [simple](azurerm/azurerm_dns_zone/simple) | A simple Azure DNS Zone |
| [azurerm_container_group](azurerm/azurerm_container_group) | [simple](azurerm/azurerm_container_group/simple) | A simple Azure Container Group |
| [azurerm_cosmosdb_account](azurerm/azurerm_cosmosdb_account) | [simple](azurerm/azurerm_cosmosdb_account/simple) | A simple Azure CosmosDB Account |
| [azurerm_function_app](azurerm/azurerm_function_app) | [simple](azurerm/azurerm_function_app/simple) | A simple Azure Function App |
| [azurerm_mariadb_server](azurerm/azurerm_mariadb_server) | [simple](azurerm/azurerm_mariadb_server/simple) | A simple Azure MariaDB Server |
| [azurerm_subnet](azurerm/azurerm_subnet) | [simple](azurerm/azurerm_subnet/simple) | A simple Azure Linux Virtual Machine |
| [azurerm_storage_queue](azurerm/azurerm_storage_queue) | [simple](azurerm/azurerm_storage_queue/simple) | A simple Azure Storage Queue |
| [azurerm_container_registry](azurerm/azurerm_container_registry) | [simple](azurerm/azurerm_container_registry/simple) | A simple Azure Container Registry |
| [azurerm_cosmosdb_gremlin_database](azurerm/azurerm_cosmosdb_gremlin_database) | [simple](azurerm/azurerm_cosmosdb_gremlin_database/simple) | A simple Azure CosmosDB Gremlin Database |
| [azurerm_storage_table](azurerm/azurerm_storage_table) | [simple](azurerm/azurerm_storage_table/simple) | A simple Azure Storage Table |
| [azurerm_sql_server](azurerm/azurerm_sql_server) | [simple](azurerm/azurerm_sql_server/simple) | A simple Azure SQL Server |
| [azurerm_subscription](azurerm/azurerm_subscription) | [enterprise_enrollment](azurerm/azurerm_subscription/enterprise_enrollment) | A Subscription attached to an existing Enterprise Enrollment Account |
| [azurerm_subscription](azurerm/azurerm_subscription) | [customer_account](azurerm/azurerm_subscription/customer_account) | A Subscription attached to an existing MCA |
| [azurerm_managed_disk](azurerm/azurerm_managed_disk) | [empty](azurerm/azurerm_managed_disk/empty) | An empty Azure Managed Disk |
| [azurerm_managed_disk](azurerm/azurerm_managed_disk) | [copy](azurerm/azurerm_managed_disk/copy) | An copy Azure Managed Disk created form another Azure Managed Disk |
| [azurerm_private_dns_zone](azurerm/azurerm_private_dns_zone) | [simple](azurerm/azurerm_private_dns_zone/simple) | A simple Azure Private DNS Zone |
| [azurerm_windows_virtual_machine](azurerm/azurerm_windows_virtual_machine) | [simple](azurerm/azurerm_windows_virtual_machine/simple) | A simple Azure Windows Virtual Machine |
| [azurerm_cosmosdb_sql_database](azurerm/azurerm_cosmosdb_sql_database) | [simple](azurerm/azurerm_cosmosdb_sql_database/simple) | A simple Azure CosmosDB SQL Database |
| [azurerm_cosmosdb_cassandra_keyspace](azurerm/azurerm_cosmosdb_cassandra_keyspace) | [simple](azurerm/azurerm_cosmosdb_cassandra_keyspace/simple) | A simple Azure CosmosDB Cassandra Keyspace |
| [azurerm_storage_blob](azurerm/azurerm_storage_blob) | [append](azurerm/azurerm_storage_blob/append) | An Azure Storage Blob using Append Block storage |
| [azurerm_storage_blob](azurerm/azurerm_storage_blob) | [page](azurerm/azurerm_storage_blob/page) | An Azure Storage Blob using Page storage |
| [azurerm_storage_blob](azurerm/azurerm_storage_blob) | [block](azurerm/azurerm_storage_blob/block) | An Azure Storage Blob using Block storage |
| [azurerm_storage_account](azurerm/azurerm_storage_account) | [simple](azurerm/azurerm_storage_account/simple) | A simple Azure Storage Account |
| [azurerm_mysql_server](azurerm/azurerm_mysql_server) | [simple](azurerm/azurerm_mysql_server/simple) | A simple Azure MySQL Server |
| [azurerm_key_vault](azurerm/azurerm_key_vault) | [simple](azurerm/azurerm_key_vault/simple) | A simple Azure Storage Container for Storage Blobs |
| [azurerm_management_group](azurerm/azurerm_management_group) | [root](azurerm/azurerm_management_group/root) | A Management Group as a child of the account root |
| [azurerm_management_group](azurerm/azurerm_management_group) | [child](azurerm/azurerm_management_group/child) | A Management Group as a child of another Management Group |
| [azurerm_virtual_machine](azurerm/azurerm_virtual_machine) | [windows](azurerm/azurerm_virtual_machine/windows) | A simple Azure Virtual Machine (deprecated in favor of the Linux and Windows specific resources) |
| [azurerm_virtual_machine](azurerm/azurerm_virtual_machine) | [linux](azurerm/azurerm_virtual_machine/linux) | A simple Azure Virtual Machine (deprecated in favor of the Linux and Windows specific resources) |
| [azurerm_postgresql_server](azurerm/azurerm_postgresql_server) | [simple](azurerm/azurerm_postgresql_server/simple) | A simple Azure PostgreSQL Server |
| [azurerm_cosmosdb_mongo_database](azurerm/azurerm_cosmosdb_mongo_database) | [simple](azurerm/azurerm_cosmosdb_mongo_database/simple) | A simple Azure CosmosDB MongoDB Database |
| [azurerm_storage_container](azurerm/azurerm_storage_container) | [simple](azurerm/azurerm_storage_container/simple) | A simple Azure Storage Container for Storage Blobs |
| [azurerm_kubernetes_cluster](azurerm/azurerm_kubernetes_cluster) | [simple](azurerm/azurerm_kubernetes_cluster/simple) | A simple Azure Kubernetes Cluster |
| [azurerm_network_interface](azurerm/azurerm_network_interface) | [simple](azurerm/azurerm_network_interface/simple) | A simple Azure Linux Virtual Machine |
| [azurerm_lb](azurerm/azurerm_lb) | [simple](azurerm/azurerm_lb/simple) | A simple Azure Load Balancer |
## BACKENDS Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [gcs](backends/gcs) | [google_storage_bucket](backends/gcs/google_storage_bucket) | Creates a persistent disk |
| [s3](backends/s3) | [aws_s3_bucket](backends/s3/aws_s3_bucket) | Creates an S3 bucket in AWS with a unique name. |
| [remote](backends/remote) | [main.tf](backends/remote/main.tf) | template for remote backend |
## DIGITALOCEAN Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [digitalocean_droplet](digitalocean/digitalocean_droplet) | [simple](digitalocean/digitalocean_droplet/simple) | Creates the simplest VM instance |
## GOOGLE Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [google_project_service](google/google_project_service) | [simple](google/google_project_service/simple) | Enables a Google Cloud API for a project |
| [google_nosql_database](google/google_nosql_database) | [cloud_bigtable](google/google_nosql_database/cloud_bigtable) | Creates a NOSQL database instance on the gcp console |
| [google_storage_bucket](google/google_storage_bucket) | [simple](google/google_storage_bucket/simple) | Creates a GCS (Google Cloud Storage) bucket |
| [google_cloud_run_service](google/google_cloud_run_service) | [noauth](google/google_cloud_run_service/noauth) | Creates a GCP Cloud Run Service accessible without auth |
| [google_cloud_run_service](google/google_cloud_run_service) | [simple](google/google_cloud_run_service/simple) | Creates the simplest GCP Cloud Run Service |
| [google_compute_attached_disk](google/google_compute_attached_disk) | [count](google/google_compute_attached_disk/count) | Uses the 'count' feature to create multiple disks attached to multiple VM instances (with google_compute_attached_disk) |
| [google_compute_attached_disk](google/google_compute_attached_disk) | [simple](google/google_compute_attached_disk/simple) | Attaches a persistent disk to an instance with google_compute_attached_disk resource type |
| [google_compute_network](google/google_compute_network) | [simple](google/google_compute_network/simple) | A simple GCP VPC (google_compute_network) |
| [google_cloud_functions](google/google_cloud_functions) | [simple](google/google_cloud_functions/simple) | A simple Cloud Function example with a dummy Python function |
| [google_compute_disk](google/google_compute_disk) | [simple](google/google_compute_disk/simple) | Creates a persistent disk |
| [google_dns_managed_zone](google/google_dns_managed_zone) | [public](google/google_dns_managed_zone/public) | Creates a public DNS managed zone |
| [google_dns_managed_zone](google/google_dns_managed_zone) | [private](google/google_dns_managed_zone/private) | Creates a private DNS managed zone |
| [google_compute_instance](google/google_compute_instance) | [simple](google/google_compute_instance/simple) | Creates the simplest VM instance |
| [google_container_cluster](google/google_container_cluster) | [autopilot](google/google_container_cluster/autopilot) | Creates a GKE (Google Kubernetes Engine) Autopilot cluster. |
| [google_container_cluster](google/google_container_cluster) | [simple](google/google_container_cluster/simple) | Creates the simplest GKE (Google Kubernetes Engine) cluster. |
| [google_container_cluster](google/google_container_cluster) | [cluster_and_deployment](google/google_container_cluster/cluster_and_deployment) | Creates a GKE (Google Kubernetes Engine) cluster, connects the Terraform Kubernetes Provider to it, and creates a k8s deployment. |
| [google_container_cluster](google/google_container_cluster) | [vpc_native_cluster](google/google_container_cluster/vpc_native_cluster) | Creates a VPC-native GKE (Google Kubernetes Engine) cluster . |
| [google_container_cluster](google/google_container_cluster) | [separate_node_pool](google/google_container_cluster/separate_node_pool) | Creates a GKE (Google Kubernetes Engine) cluster with a separatelly managed node pool. |
| [google_sql_database](google/google_sql_database) | [simple](google/google_sql_database/simple) | Creates a SQL database instance on the gcp console |
## HELM Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [helm_release](helm/helm_release) | [simple](helm/helm_release/simple) | Example helm_release resource |
| [helm_release](helm/helm_release) | [values_from_file](helm/helm_release/values_from_file) | Example helm_release, getting values from a file |
## KUBERNETES Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [kubernetes_config_map](kubernetes/kubernetes_config_map) | [from_files](kubernetes/kubernetes_config_map/from_files) | Kubernetes configmap from files |
| [kubernetes_config_map](kubernetes/kubernetes_config_map) | [simple](kubernetes/kubernetes_config_map/simple) | Creates a Kubernetes configmap |
| [kubernetes_deployment](kubernetes/kubernetes_deployment) | [simple](kubernetes/kubernetes_deployment/simple) | A Kubernetes deployment |
| [kubernetes_deployment](kubernetes/kubernetes_deployment) | [deployment_and_service](kubernetes/kubernetes_deployment/deployment_and_service) | Create a Kubernetes deployment and service |
| [kubernetes_service](kubernetes/kubernetes_service) | [simple](kubernetes/kubernetes_service/simple) | A kubernetes service |
| [kubernetes_namespace](kubernetes/kubernetes_namespace) | [simple](kubernetes/kubernetes_namespace/simple) | A Kubernetes namespace |
## LINODE Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [linode_instance](linode/linode_instance) | [simple](linode/linode_instance/simple) | Creates the simplest VM instance |
## LOCAL Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [null_resource](local/null_resource) | [for_each](local/null_resource/for_each) | Local null resource that iterates over a map using for_each |
| [null_resource](local/null_resource) | [simple](local/null_resource/simple) | Simple example of local null_resource that runs a command |
| [local_file](local/local_file) | [hello](local/local_file/hello) | Create and manage a local file. |
| [local_file](local/local_file) | [preexisting_file](local/local_file/preexisting_file) | Take an existing file into a Terraform state, using data.local_file's configuration. |
## MODULES Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [local_file](modules/local_file) | [hello_consumer](modules/local_file/hello_consumer) | A module consumer |
| [local_file](modules/local_file) | [hello_module](modules/local_file/hello_module) | A local_file example to be used as a module |
## OUTPUTS Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [local_file](outputs/local_file) | [module](outputs/local_file/module) | Example of including a module and outputting a variable from it |
| [local_file](outputs/local_file) | [local_file](outputs/local_file/local_file) | Example of output of local_file filename |
## VARIABLES Examples
| Resource      | Feature       | Summary       |
| ------------- |:-------------:|:-------------|
| [local_file](variables/local_file) | [module](variables/local_file/module) | This example uses the `../local_file` module to give an example using modules. |
| [local_file](variables/local_file) | [local_file](variables/local_file/local_file) | Creates a local file with some content. |
