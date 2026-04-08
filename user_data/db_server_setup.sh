#!/bin/bash
yum update -y
amazon-linux-extras enable postgresql14
yum clean metadata
yum install -y postgresql-server postgresql

postgresql-setup initdb
systemctl start postgresql
systemctl enable postgresql