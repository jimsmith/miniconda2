#!/bin/bash

# 06/03/2018 - Jim Smith
#  - A single miniconda bootstrap script for the impatient!
#  - May not continue fully but will get most of it up and running, simply pick up were it finishes off.
#  - Suits my own needs!

cd ~
pwd
mkdir -p miniconda && cd miniconda

export MINICONDA_VERSION=latest \
wget https://repo.continuum.io/miniconda/Miniconda2-${MINICONDA_VERSION}-Linux-x86_64.sh \
&& chmod 755 Miniconda2-${MINICONDA_VERSION}-Linux-x86_64.sh \
&& ./Miniconda2-${MINICONDA_VERSION}-Linux-x86_64.sh -b -p ~/miniconda2

wget https://raw.githubusercontent.com/jimsmith/miniconda/master/.condarc -O ~/.condarc \
wget https://raw.githubusercontent.com/jimsmith/miniconda/master/conda_auto_env.sh -O ~/conda_auto_env.sh \
chmod 755 ~/conda_auto_env.sh

cat <<EOF >>~/.bashrc
#
# 01/03/2018 - added Minicoda2 path
export PATH=~/miniconda2/bin:$PATH
#
# 01/03/2018 - added conda autoswitching
source ~/conda_auto_env.sh
EOF

source ~/.bashrc

which conda
conda update conda

mkdir -p ~/miniconda/awscli/ && cd ~/miniconda/awscli/ \
&& wget https://raw.githubusercontent.com/jimsmith/miniconda/master/environment.yml

conda create --yes --quiet --name awscli python=2.7 pip

pip install -r https://raw.githubusercontent.com/jimsmith/miniconda/master/latest-requirements.txt

ansible --version
aws --version

cat <<EOF >>~/.bashrc
#
# 01/03/2018 - added aws autocomplete
complete -C '~/miniconda2/envs/awscli/bin/aws_completer' aws
#
EOF

complete -C '~/miniconda2/envs/awscli/bin/aws_completer' aws


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

aws iam list-users

export EC2_INI_PATH=~/miniconda/awscli/ec2.ini
chmod 755 ec2.py
./ec2.py --refresh

ansible -i ./ec2.py -m ping localhost
