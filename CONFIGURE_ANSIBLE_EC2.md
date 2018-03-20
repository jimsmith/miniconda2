After you have Miniconda environment completed, now is the time to configure Ansible's EC2 Dynamic Inventory

###  Bonus points for infrastructure sanity testing
```
wget --no-check-certificate https://raw.github.com/ansible/ansible/devel/contrib/inventory/ec2.py
wget --no-check-certificate https://raw.github.com/ansible/ansible/devel/contrib/inventory/ec2.ini

sed -i 's/all_instances = False/all_instances = True/g' ec2.ini
sed -i 's/destination_variable = public_dns_name/destination_variable = private_dns_name/g' ec2.ini
sed -i 's/vpc_destination_variable = ip_address/vpc_destination_variable = private_ip_address/g' ec2.ini
sed -i 's/route53 = False/route53 = True/g' ec2.ini
sed -i 's/all_rds_instances = False/all_rds_instances = True/g' ec2.ini
sed -i 's/include_rds_clusters = False/include_rds_clusters = True/g' ec2.ini
sed -i 's/all_elasticache_replication_groups = False/all_elasticache_replication_groups = True/g' ec2.ini
sed -i 's/all_elasticache_clusters = False/all_elasticache_clusters = True/g' ec2.ini
sed -i 's/all_elasticache_nodes = False/all_elasticache_nodes = True/g' ec2.ini

export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_DEFAULT_REGION=
aws iam list-users

export EC2_INI_PATH=~/miniconda/awscli/ec2.ini
chmod 755 ec2.py
./ec2.py --refresh

ansible -i ./ec2.py -m ping localhost
```


For Mac OSX (10.12.6) users the following sed command has known to work:
```
sed -i=''  's/all_instances = False/all_instances = True/g' ec2.ini
sed -i='' 's/destination_variable = public_dns_name/destination_variable = private_dns_name/g' ec2.ini
sed -i='' 's/vpc_destination_variable = ip_address/vpc_destination_variable = private_ip_address/g' ec2.ini
sed -i='' 's/route53 = False/route53 = True/g' ec2.ini
sed -i='' 's/all_rds_instances = False/all_rds_instances = True/g' ec2.ini
sed -i='' 's/include_rds_clusters = False/include_rds_clusters = True/g' ec2.ini
sed -i='' 's/all_elasticache_replication_groups = False/all_elasticache_replication_groups = True/g' ec2.ini
sed -i='' 's/all_elasticache_clusters = False/all_elasticache_clusters = True/g' ec2.ini
sed -i='' 's/all_elasticache_nodes = False/all_elasticache_nodes = True/g' ec2.ini
```
