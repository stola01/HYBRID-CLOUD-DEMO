set 'auto.offset.reset'='earliest';
CREATE TABLE users (userid VARCHAR PRIMARY KEY, registertime BIGINT, gender VARCHAR, regionid VARCHAR) WITH
(KAFKA_TOPIC='users', VALUE_FORMAT='JSON');

