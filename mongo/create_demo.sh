#!/bin/bash

# Register engines
/root/dct-toolkit register_engine hostname=10.160.1.18 name=sourcecde username=admin password=Delphix_123! --insecure_ssl  
/root/dct-toolkit register_engine hostname=10.160.1.162 name=cce3 masking_username=admin masking_password=Delphix_123! --insecure_ssl 

# Create environmnent
/root/dct-toolkit create_environment engine_id='sourcecde' name='Mongodb_Source' os_name='UNIX' hostname='10.160.1.26' toolkit_path='/toolkit' username='delphix' password='delphix' description='Mongodb Source VM'
/root/dct-toolkit create_environment engine_id='sourcecde' name='Mongodb_Target' os_name='UNIX' hostname='10.160.1.69' toolkit_path='/toolkit' username='delphix' password='delphix' description='Mongodb Target VM'

# Create Source
/root/dct-toolkit create_app_data_source name="mongodb_source" environment_id="Mongodb_Source" repository_id="MongoDB - (version: v4.4.13) [/usr/bin/mongod]" type="STAGED" engine_id="sourcecde" parameters='{"pretty_name": "mongo-stg"}'

# Create Dsource (takes around 28 minutes)
/root/dct-toolkit link_appdata_database name="Mongodb_master" source_id="mongodb_source" group_id="Source" link_type=AppDataStaged staging_environment="Mongodb_Target" environment_user="delphix" sync_parameters='{"resync": true}' parameters='{"dsource_type_definition":"onlinemongodump - [Replicaset(Automated mongodump backups)]","src_db_details":[{"host_conn_string":"10.160.1.26:27017","db_user":"delphix","db_password":"delphix"}],"staging_db_details":[{"replicaset_name":"sr0","staging_host":"10.160.1.69","mount_path":"/mnt/provision/mongodb_staging","bind_ip":"0.0.0.0","start_portpool":28000}],"staging_tuning_details":[],"mongodump_config":[],"shard_details":[],"ops_backup_details":[],"enable_authentication":true,"staging_db_auth":[{"mongo_db_user":"dlpxadm","mongo_db_password":"dlpxadm","cluster_auth_mode":"keyFile","keyfile_path":"/home/delphix/keyfile/keyfile"}],"enable_ssl_tls":false,"ssl_tls_params":[],"enable_ldap":false,"ldap_params":[],"source_encrypted":false,"encryption_params":[],"client_tls_cert":"","client_tls_cacert":""}'

# Create MASK VDB from PROD
/root/dct-toolkit provision_vdb_by_snapshot appdata source_data_id='Mongodb_master' name='Mongodb_MASK' environment_id='Mongodb_Target' environment_user_id='delphix' --auto_select_repository target_group_id='MaskGC' appdata_source_params='{"additional_nodes": [], "client_tls_cacert": "", "client_tls_cert": "", "enable_authentication": false, "enable_ldap": false, "enable_ssl_tls": false, "encryption_params": [], "ldap_params": [], "ssl_tls_params": [], "vdb_auth_details": [], "vdb_details": [{"bind_ip": "0.0.0.0", "make_shards_replicaset": false, "mount_path": "/mnt/provision/mongdb_MASK", "start_portpool": 28500}], "vdb_sharded_details": [], "vdb_tuning_details": []}' --masked

# Run Masking
/root/dct-toolkit execute_masking_job engine_id=cce3 masking_job_id='MaskMongoDB_MASK'

# Bookmark MASK VDB
/root/dct-toolkit create_bookmark vdb_ids='Mongodb_MASK' name="PIT $(date -u)"

# Create DEV and QA VDBs from MASK
/root/dct-toolkit provision_vdb_by_snapshot appdata source_data_id='Mongodb_MASK' name='Mongodb_DEV' environment_id='Mongodb_Target' environment_user_id='delphix' --auto_select_repository target_group_id='DEV' appdata_source_params='{"additional_nodes": [], "client_tls_cacert": "", "client_tls_cert": "", "enable_authentication": false, "enable_ldap": false, "enable_ssl_tls": false, "encryption_params": [], "ldap_params": [], "ssl_tls_params": [], "vdb_auth_details": [], "vdb_details": [{"bind_ip": "0.0.0.0", "make_shards_replicaset": false, "mount_path": "/mnt/provision/mongdb_DEV", "start_portpool": 28600}], "vdb_sharded_details": [], "vdb_tuning_details": []}'
/root/dct-toolkit provision_vdb_by_snapshot appdata source_data_id='Mongodb_MASK' name='Mongodb_QA' environment_id='Mongodb_Target' environment_user_id='delphix' --auto_select_repository target_group_id='QA' appdata_source_params='{"additional_nodes": [], "client_tls_cacert": "", "client_tls_cert": "", "enable_authentication": false, "enable_ldap": false, "enable_ssl_tls": false, "encryption_params": [], "ldap_params": [], "ssl_tls_params": [], "vdb_auth_details": [], "vdb_details": [{"bind_ip": "0.0.0.0", "make_shards_replicaset": false, "mount_path": "/mnt/provision/mongdb_QA", "start_portpool": 28700}], "vdb_sharded_details": [], "vdb_tuning_details": []}'
