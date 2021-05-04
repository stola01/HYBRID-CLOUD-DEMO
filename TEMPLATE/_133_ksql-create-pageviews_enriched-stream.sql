set 'auto.offset.reset'='earliest';
CREATE STREAM pageviews_enriched
WITH (kafka_topic='pageviews_enriched', partitions=1, value_format='json')
AS
SELECT users.userid AS userid, pageid, regionid, gender
FROM pageviews_original
LEFT JOIN users
  ON pageviews_original.userid = users.userid
EMIT CHANGES;

