/*
 * Calculates the hashtags that are commonly used for English tweets containing the word "coronavirus"
 */

select
    '#' || tag as tag,
    count(*) as count
from (
    select distinct
        data->>'id' id_tweets,
        jsonb_array_elements_text(
                COALESCE(data->'entities'->'hashtags','[]') ||
                COALESCE(data->'extended_tweet'->'entities'->'hashtags','[]'))::jsonb ->> 'text' as tag
    from tweets_jsonb
    where to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text'))@@to_tsquery('english', 'coronavirus')
        and data->>'lang' = 'en'
) t
group by tag
order by count desc, tag
limit 1000
;
