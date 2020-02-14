# EE Solutions

terraform binary has been compressed alongside with the code which decreses version syntax issues..

```
$ unzip terraform-v0.12.8.zip
$ ./terraform init
```

```
$ ./terraform validate
Success! The configuration is valid.
```

```
$ ./terraform apply
data.aws_ami.centos: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

<Skipped> 
.
.
.

Plan: 16 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: no

Apply cancelled.
```
