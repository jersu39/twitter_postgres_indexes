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

create index on tweets_jsonb using gin(to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text'))) where (data->>'lang'='en');

