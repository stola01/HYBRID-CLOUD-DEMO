set 'auto.offset.reset'='earliest';
CREATE STREAM pageviews_enriched_avro
WITH (kafka_topic='pageviews_enriched_avro', partitions=1, value_format='avro')
AS
SELECT * FROM pageviews_enriched
EMIT CHANGES;

