SELECT 
'#' || tag as tag,
count(*) as count
FROM (SELECT DISTINCT 
        t1.data->>'id' as id, 
        jsonb_array_elements( COALESCE(t1.data->'entities'->'hashtags','[]') ||
                COALESCE(t1.data->'extended_tweet'->'entities'->'hashtags','[]'))->>'text' as tag 
FROM tweets_jsonb t1 
WHERE t1.data->'entities'->'hashtags' @@ '$[*].text== "coronavirus" '
OR    t1.data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus" '
) t
group by (1)
ORDER BY count DESC, tag
LIMIT 1000;
