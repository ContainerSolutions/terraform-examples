Connection to Windows instances should be done using WinRM.
In this example WinRM is enabled in the instance's user_data.

After that, the assigned password is retrieved using the [`get_password_data`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#get_password_data) argument and the private key. We use the `Administrator` user and its retrieved password to connect to the instance, copy the [hello.ps1](../scripts/hello.ps1) script and execute it.

To run this:

```
../../../../../bin/apply_aws.sh
```
