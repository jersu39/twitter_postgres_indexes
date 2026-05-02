create index on tweets_jsonb ((data->>'id'));

create index on tweets_jsonb using gin(
    coalesce(data->'entities'->'hashtags',
            data->'extended_tweet'->'entities'->'hashtags',
            '[]') jsonb_path_ops);

create index on tweets_jsonb using gin((data->'entities'->'hashtags'));

create index on tweets_jsonb using gin((data->'extended_tweet'->'entities'->'hashtags'));

create index on tweets_jsonb ((data->>'lang'));

create index on tweets_jsonb using gin(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text')));

create index on tweets_jsonb ((data ->>'id'), (data->>'lang'));




/*

where data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
    or data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]';

where data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
    or data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
group by tag
order by count desc, tag

where data->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
    or data->'extended_tweet'->'entities'->'hashtags' @> '[{"text": "coronavirus"}]'
group by lang
order by count desc, lang;

where to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text'))@@to_tsquery('english', 'coronavirus')
    and data->>'lang' = 'en'

    where to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text',data->>'text'))@@to_tsquery('english', 'coronavirus')
        and data->>'lang' = 'en'
) t
group by tag
order by count desc, tag

*/
