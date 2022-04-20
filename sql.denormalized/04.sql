SELECT count(*) from tweets_jsonb as t 
WHERE 
to_tsvector('english',coalesce(t.data->'extended_tweet'->>'full_text',t.data->>'text')) @@ to_tsquery('english','coronavirus')
AND t.data ->>'lang' = 'en';
