## Miniconda is a platform independent python environment that is easily configured with python and pip support without the need of root user.

### Get into my home directory and create directory
```
cd ~
pwd
mkdir -p miniconda && cd miniconda
```


### Download and install into my directory
```
wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh
chmod 755 Miniconda2-latest-Linux-x86_64.sh
./Miniconda2-latest-Linux-x86_64.sh -b -p ~/miniconda2
```


### Create default condarc
```
cat <<EOF >~/.condarc
# installing a new environments add these packages by default
create_default_packages:
  - python
  - pip

# implies always using the --yes option whenever asked to proceed
always_yes: True

channels:
  - defaults

EOF
cat ~/.condarc
```

### Update my bashrc
```
cat <<EOF >>~/.bashrc
#
# 01/03/2018 - added Minicoda2 path
export PATH=~/miniconda2/bin:$PATH
#
EOF
```

### Activate without logging out
```
source ~/.bashrc
```

### Update conda to latest version
```
which conda
conda update conda
```


### Now create my miniconda environment with Python 2.7 for the python interpreter
```
conda create --yes --quiet --name ansible-latest python=2.7 pip
```

### Activate the environment
```
source activate ansible-latest

(ansible-latest) [jim@centos7 miniconda]$ pwd
/home/jim/miniconda
```

### Next install the programs I need from latest-requirements.txt
```
(ansible-latest) [jim@centos7 miniconda]$ pip install -r latest-requirements.txt
```

### Bonus points confirming they are installed.
```
(ansible-latest) [jim@centos7 miniconda]$ ansible --version
(ansible-latest) [jim@centos7 miniconda]$ aws --version
```

### Extra Bonus points for infrastructure sanity testing
```
 export AWS_ACCESS_KEY_ID=
 export AWS_SECRET_ACCESS_KEY=
 export AWS_DEFAULT_REGION=
 aws iam list-users
 
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

export EC2_INI_PATH=~/miniconda/ec2.ini
chmod 755 ec2.py
./ec2.py --refresh

ansible -i ./ec2.py -m ping localhost
 ```
