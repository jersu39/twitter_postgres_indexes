/*
 * Count the number of tweets that use #coronavirus
 */

SELECT count(distinct id_tweets)
FROM tweet_tags
WHERE tag='#coronavirus';



-- goal: write create index cm to make ^ fast
-- use index only scan

-- gen rule w/ multicol idx: put = constraint first
-- anything sorted, immed after == col

-- typical runtime: 5-30 minutes

-- dramatically slower to load data after create index

-- sometimes seq scan fastest, only 1 page read req
-- idx scan alw req 2+ page reads

-- must vacuum after inesrt data
-- if dont, query planner might choose very wrongly

-- vacuum maintains pg_class + deletes dead tuples + maintains visibility map

-- useful debug
-- select reltuples, relpages from pg_class where relname='tweet_tags';

-- figuring out what scans can be used
-- set enable_seqscan=off
-- run explain
