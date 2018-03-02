## Miniconda is a platform independent python environment that is easily configured with python and pip support without the need of root user.

A use case maybe you do not have root access or takes a very long time to get certain devops/cloud/automation tooling to be available for you and you need to get to work 'fast'.

I chose to use miniconda and not virtualenv (which requires to be on the server to begin with and installed with root user privileges and after using it extensively it's very clunky and very selective on environment variables/$PATH) miniconda does not require such permissions.

For further reading check out this https://news.ycombinator.com/item?id=11374804

Time to get you up and running about 7 minutes.


### Get into my home directory and create directory
```
cd ~
pwd
mkdir -p miniconda && cd miniconda
```


### Download and install into my directory
```
MINICONDA_VERSION=latest \
wget https://repo.continuum.io/miniconda/Miniconda2-${MINICONDA_VERSION}-Linux-x86_64.sh \
chmod 755 Miniconda2-${MINICONDA_VERSION}-Linux-x86_64.sh \
./Miniconda2-${MINICONDA_VERSION}-Linux-x86_64.sh -b -p ~/miniconda2

```


### Download default condarc and autoswitching (when entering a directory)
```
wget https://raw.githubusercontent.com/jimsmith/miniconda/master/.condarc -O ~/.condarc \
wget https://raw.githubusercontent.com/jimsmith/miniconda/master/conda_auto_env.sh -O ~/conda_auto_env.sh \
chmod 755 ~/conda_auto_env.sh

```

### Update my bashrc
```
cat <<EOF >>~/.bashrc
#
# 01/03/2018 - added Minicoda2 path
export PATH=~/miniconda2/bin:$PATH
#
# 01/03/2018 - added conda autoswitching
source ~/conda_auto_env.sh
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

### Setup autoswitching
```
mkdir -p ~/miniconda/awscli/ && cd ~/miniconda/awscli/ \
wget https://raw.githubusercontent.com/jimsmith/miniconda/master/environment.yml

```

If you experience message of `-bash: PROMPT_COMMAND: readonly variable` then check that this is not been set elsewhere for example in `/etc/bashrc`

### Now create my miniconda environment with Python 2.7 for the python interpreter
```
conda create --yes --quiet --name awscli python=2.7 pip
  
```

Tip: to activate the environment manually:
```
source activate awscli

(awscli) [jim@centos7 miniconda]$ pwd
/home/jim/miniconda/awscli
```

### Next install the programs I need from latest-requirements.txt
```
(awscli) [jim@centos7 miniconda]$ pip install -r https://raw.githubusercontent.com/jimsmith/miniconda/master/latest-requirements.txt
```

### Bonus points confirming they are installed.
```
(awscli) [jim@centos7 miniconda]$ ansible --version
(awscli) [jim@centos7 miniconda]$ aws --version
```

### Next go and configure Ansible's EC2 Dynamic Inventory 
https://github.com/jimsmith/miniconda/blob/master/CONFIGURE_ANSIBLE_EC2.md

