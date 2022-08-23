opsworks-redis-cluster-Cookbook
===============================
This cookbook will install and configure a redis cluster using a redis-server and redis-sentinel.

Requirements
------------
This cookbook is written for OpsWorks so can be deployed using cloudformation.

How it Works
-----
#### opsworks-redis-cluster::master
Installs redis-server and redis-sentinel with this node as master. redis-sentinel configuration will initially monitor this node.

#### opsworks-redis-cluster::slave
Installs redis-server and redis-sentinel with this node as a slave. redis-server configuration will include slaveof and point to the master node.
