/*
 * Count the number of tweets that use #coronavirus
 */


select count(distinct data->>'id')
from tweets_jsonb
where data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
    or data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]';

