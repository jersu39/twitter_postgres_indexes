/*
 * Count the number of English tweets containing the word "coronavirus"
 */

/*
SELECT
    count(*)
FROM tweets
WHERE to_tsvector('english',text)@@to_tsquery('english','coronavirus')
  AND lang='en'
;
*/

select
    count(*)
from tweets_jsonb
where to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text'))@@to_tsquery('english', 'coronavirus')
    and data->>'lang' = 'en'
;
