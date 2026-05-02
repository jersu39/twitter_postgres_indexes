/*
 * Calculates the languages that use the hashtag #coronavirus
 */

/*
SELECT
    lang,
    count(DISTINCT id_tweets) as count
FROM tweet_tags
JOIN tweets USING (id_tweets)
WHERE tag='#coronavirus'
GROUP BY lang
ORDER BY count DESC,lang;
*/

select
    data ->> 'lang' as lang,
    count(distinct data->>'id') as count
from tweets_jsonb
where data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
    or data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
group by lang
order by count desc, lang;
