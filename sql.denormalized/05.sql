SELECT 
'#' || tag as tag,
count(*) as count
FROM (SELECT DISTINCT t1.data->>'id' as id, 
                jsonb_array_elements( COALESCE(t1.data->'entities'->'hashtags','[]') ||
                COALESCE(t1.data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text' as tag 
FROM tweets_jsonb t1 
WHERE to_tsvector('english',COALESCE(data->'extended_tweet'->>'full_text',data->>'text')) @@ to_tsquery('english', 'coronavirus')
        AND t1.data ->>'lang' = 'en'
) t
group by (1)
ORDER BY count DESC, tag
LIMIT 1000;
