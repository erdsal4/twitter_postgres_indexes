SELECT 
lang,
count(*) as count
FROM (SELECT DISTINCT 
    t1.data->>'id' as id, t1.data->>'lang' as lang                
    FROM tweets_jsonb t1 
    WHERE t1.data->'entities'->'hashtags' @@ '$[*].text== "coronavirus" '
    OR    t1.data->'extended_tweet'->'entities'->'hashtags' @@ '$[*].text == "coronavirus" '
) t
group by (1)
ORDER BY count DESC, lang;
