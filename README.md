# oci-splunk
This is a Terraform module that deploys [Splunk Enterprise](https://www.splunk.com/) on [Oracle Cloud Infrastructure (OCI)](https://cloud.oracle.com/en_US/cloud-infrastructure).  It is developed jointly by Oracle and Splunk.

## Prerequisites
First off you'll need to do some pre deploy setup.  That's all detailed [here](https://github.com/oracle/oci-quickstart-prerequisites).

## Clone the Module
Now, you'll want a local copy of this repo by running:

    git clone https://github.com/oracle-quickstart/oci-splunk.git

## Deploy
The TF templates here can be deployed by running the following commands:
```
cd oci-splunk/simple
terraform init
terraform plan
terraform apply
```

Using the defaults in `variables.tf` these templates will deploy:
- a VNC
- a master instance (`admin` password is set by the `password` variable)
- 2 indexer instances (one for each site in the `sites_string` variable)
- a search deployer instance
- 2 search head instances

The output of `terraform apply` should look like:
```
Apply complete! Resources: 11 added, 0 changed, 0 destroyed.

Outputs:

Indexer server private IPs = [
    10.0.0.6,
    10.0.0.7
]
Indexer server public IPs = [
    129.213.90.194,
    132.145.197.110
]
Master server URL = http://150.136.210.4:8000
Master server private IP = 10.0.0.3
Master server public IP = 150.136.210.4
Search deployer server private IP = 10.0.0.2
Search deployer server public IP = 129.213.94.65
Search head server private IPs = [
    10.0.0.4,
    10.0.0.5
]
Search head server public IPs = [
    132.145.132.203,
    129.213.22.201
]
```

The deployment will finish asynchronously after `terraform apply` returns. Once
this completes you'll be able to log into the Splunk admin console by opening the
`Master server URL` in a browser. The login is `admin/<password variable in variables.tf>`

## Contributing

This project welcomes contributions from the community. Before submitting a pull request, please [review our contribution guide](./CONTRIBUTING.md)

## Security

Please consult the [security guide](./SECURITY.md) for our responsible security vulnerability disclosure process

## License

Copyright (c) 2023 Oracle and/or its affiliates.

Released under the Apache License version 2.0 as shown at
<http://www.apache.org/licenses/>.

