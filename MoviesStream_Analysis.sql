-- Users + WatchHistory + Movies
SELECT u.name, u.country, m.title, m.genre, w.watch_date, w.duration_watched, w.revenue
FROM WatchHistory w
JOIN Users u ON w.user_id = u.user_id
JOIN Movies m ON w.movie_id = m.movie_id;


-- Movies + Ratings + Users
SELECT m.title, m.genre, r.rating, r.review, u.country
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
JOIN Users u ON r.user_id = u.user_id;


-- Which country has the most Premium plan users? 
SELECT u.country,
       COUNT(*) AS total_premium_users
FROM Users u
JOIN Subscriptions s ON u.user_id = s.user_id
WHERE s.plan_type = 'Premium'
GROUP BY u.country
ORDER BY total_premium_users DESC;


-- Average subscription duration (days) by plan type
SELECT plan_type,
       ROUND(AVG(DATEDIFF(end_date, start_date)), 2) AS avg_duration_days
FROM Subscriptions
GROUP BY plan_type;


-- Which year had the highest number of signups?
SELECT YEAR(signup_date) AS signup_year,
       COUNT(*) AS total_signups
FROM Users
GROUP BY signup_year
ORDER BY total_signups DESC; 


-- Which movie genre has the highest average rating?
SELECT m.genre,
       ROUND(AVG(r.rating), 2) AS avg_rating
FROM Ratings r
JOIN Movies m ON r.movie_id = m.movie_id
GROUP BY m.genre
ORDER BY avg_rating DESC;


-- Average rating by movie region
SELECT m.region,
       ROUND(AVG(r.rating), 2) AS avg_rating
FROM Movies m
JOIN Ratings r ON m.movie_id = r.movie_id
GROUP BY m.region
ORDER BY avg_rating DESC;


-- Total revenue per movie 
SELECT m.title,
       ROUND(SUM(w.revenue), 2) AS total_revenue
FROM Movies m
JOIN WatchHistory w ON m.movie_id = w.movie_id
GROUP BY m.title
ORDER BY total_revenue DESC;


-- Which country generated the most revenue?
SELECT u.country,
       ROUND(SUM(w.revenue), 2) AS total_revenue
FROM WatchHistory w
JOIN Users u ON w.user_id = u.user_id
GROUP BY u.country
ORDER BY total_revenue DESC;


-- Average watch duration by genre
SELECT m.genre, ROUND(AVG(w.duration_watched), 2) AS avg_watch_duration
FROM Movies m
JOIN WatchHistory w ON m.movie_id = w.movie_id
GROUP BY m.genre
ORDER BY avg_watch_duration DESC;


-- Most active country in 2025 (watch count)
SELECT u.country,
       COUNT(w.history_id) AS total_watches
FROM WatchHistory w
JOIN Users u ON w.user_id = u.user_id
WHERE YEAR(w.watch_date) = 2025
GROUP BY u.country
ORDER BY total_watches DESC;


-- Average rating given by Premium vs Basic users 
SELECT s.plan_type,
       ROUND(AVG(r.rating), 2) AS avg_rating
FROM Subscriptions s
JOIN Ratings r ON s.user_id = r.user_id
GROUP BY s.plan_type
HAVING s.plan_type IN ('Premium', 'Basic');

