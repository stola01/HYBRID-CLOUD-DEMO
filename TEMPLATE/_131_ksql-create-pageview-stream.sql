set 'auto.offset.reset'='earliest';
CREATE STREAM pageviews_original (viewtime bigint, userid varchar, pageid varchar) WITH
(kafka_topic='pageviews', value_format='JSON');

