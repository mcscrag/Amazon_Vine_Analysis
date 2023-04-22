-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating INTEGER,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

SELECT * FROM vine_table;

-- step 1
SELECT * INTO filtered_vine FROM vine_table
WHERE total_votes >= 20;

-- step 2
SELECT * INTO step_2_vine FROM filtered_vine
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >= 0.5;

SELECT * FROM step_2_vine;

-- step 3
SELECT * INTO step_3_vine_paid FROM step_2_vine
WHERE vine = 'Y';

SELECT * INTO step_3_vine_unpaid FROM step_2_vine
WHERE vine = 'N';

SELECT * FROM step_3_vine_paid;
SELECT * FROM step_3_vine_unpaid;

SELECT COUNT(review_id) AS paid_review_count, 
COUNT(case when star_rating = 5 then 1 else null end) AS paid_five_star_count
-- (SELECT COUNT(case when star_rating = 5 then 1 else null end) FROM step_3_vine_paid)/(SELECT COUNT(review_id) FROM step_3_vine_paid) AS percent_five_star
INTO paid_vine_count
FROM step_3_vine_paid;

SELECT COUNT(review_id) AS unpaid_review_count, 
COUNT(case when star_rating = 5 then 1 else null end) AS unpaid_five_star_count
INTO unpaid_vine_count
FROM step_3_vine_unpaid;

SELECT * FROM paid_vine_count;
SELECT * FROM unpaid_vine_count;

SELECT paid_review_count,
paid_five_star_count,
CAST((paid_five_star_count * 100/paid_review_count) AS NUMERIC(10,2)) AS paid_percent_five_star
INTO paid_summary
FROM paid_vine_count;


SELECT unpaid_review_count,
unpaid_five_star_count,
CAST((unpaid_five_star_count * 100/unpaid_review_count) AS NUMERIC(10,2)) AS unpaid_percent_five_star
INTO unpaid_summary
FROM unpaid_vine_count;

SELECT * FROM paid_summary;
SELECT * FROM unpaid_summary;