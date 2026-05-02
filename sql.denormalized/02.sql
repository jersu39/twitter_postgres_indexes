/*
 * Calculates the hashtags that are commonly used with the hashtag #coronavirus
 */

select
   '#' || tag as tag, count(*) as count
from (
    select distinct
        data ->> 'id' as id_tweets,
        jsonb_array_elements_text(
            coalesce(data->'extended_tweet'->'entities'->'hashtags',
                    data->'entities'->'hashtags',
                    '[]')
            )::jsonb ->> 'text' as tag
    from tweets_jsonb
    where data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
    or data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
) t
group by tag
order by count desc, tag
limit 1000;
