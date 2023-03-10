Create database playstores;
Use playstores;

Create table playstore_apps
(App varchar(100),
Category varchar(100),
Rating	double,
Reviews	 int,
Size	varchar(100),
Installs int,
Type varchar(100),	
Price int,	
Content_Rating	varchar(100),
Genres	varchar(100),
Last_Updated varchar(100),	
Current_Ver	varchar(100),
Android_Ver varchar(100));

Create table playstore_reviews
(App varchar(100),
Translated_Review varchar(200),
Sentiment varchar(10),
Sentiment_Polarity	integer,
Sentiment_Subjectivity integer);

# Q1 Which apps have the highest rating in the given available dataset?
SELECT App, Rating
FROM playstore_apps
WHERE Rating = (SELECT MAX(Rating) FROM playstore_apps);

# Q2 What are the number of installs and reviews for the above apps? Return the apps with the highest reviews to the top.
SELECT App, Installs, Reviews
FROM playstore_apps
WHERE Rating = (SELECT MAX(Rating) FROM playstore_apps)
ORDER BY Reviews DESC;

# Q3 Which app has the highest number of reviews? Also, mention the number of reviews and category of the app
SELECT App, Reviews, Category
FROM playstore_apps
WHERE Reviews = (SELECT MAX(Reviews) FROM playstore_apps);

# Q4 What is the total amount of revenue generated by the google play store by hosting apps? (Whenever a user buys apps  from the google play store, the amount is considered in the revenue)#
SELECT Type, SUM(Installs*Price) AS total_installs_price
FROM playstore_apps
WHERE Type = 'Paid'
Group by Type;

# Q5 Which Category of google play store apps has the highest number of installs? also, find out the total number of installs for that particular category.
SELECT Category, SUM(Installs) as Total_Installs
FROM playstore_apps
GROUP BY Category
ORDER BY Total_Installs DESC
LIMIT 1;

# Q6 Which Genre has the most number of published apps?
SELECT Genres, COUNT(*) as App_Count
FROM playstore_apps
GROUP BY Genres
ORDER BY App_Count DESC
LIMIT 1;

# Q7 Provide the list of all games ordered in such a way that the game that has the highest number of installs is displayed on the top(to avoid duplicate results use distinct)
SELECT DISTINCT App, Installs
FROM playstore_apps
WHERE Genres LIKE '%Games%'
ORDER BY Installs DESC;

# Q8 Provide the list of apps that can work on android version 4.0.3 and UP.
Select App from playstore_apps
where Android_Ver ="4.0.3 and up";

# Q9 How many apps from the given data set are free? Also, provide the number of paid apps.
SELECT Type, COUNT(*) as App_Count
FROM playstore_apps
Group By Type;

# Q10 Which is the best dating app? (Best dating app is the one having the highest number of Reviews)
SELECT App, Reviews
FROM playstore_apps
WHERE Genres LIKE '%Dating%'
ORDER BY Reviews DESC
LIMIT 1;

# 11. Get the number of reviews having positive sentiment and number of reviews having negative sentiment for the app 10 best foods for you and compare them.

SELECT App,
           SUM(CASE
           WHEN Sentiment = 'Positive' THEN 1
           ELSE 0
           END) AS No_of_positives,
           SUM(CASE
           WHEN Sentiment = 'Negative' THEN 1
           ELSE 0
           END) AS No_of_Negatives
 FROM Playstore_reviews
WHERE App = '10 best foods for you';

# 12.Which comments of ASUS SuperNote have sentiment polarity and sentiment subjectivity both as 1?

SELECT Translated_Review
  FROM Playstore_reviews 
 WHERE App = 'ASUS SuperNote' 
   AND  Sentiment_Polarity = 1 
   AND  Sentiment_Subjectivity = 1;

# 13.Get all the neutral sentiment reviews for the app Abs Training-Burn belly fat 

SELECT Translated_Review 
  FROM Playstore_reviews 
 WHERE App = 'Abs Training-Burn belly fat' 
   AND Sentiment = 'Neutral';
   
 #14. Extract all negative sentiment reviews for Adobe Acrobat Reader with their sentiment polarity and sentiment subjectivity

SELECT App,
            Translated_Review,
            Sentiment_polarity,
            Sentiment_subjectivity 
  FROM Playstore_Reviews 
WHERE App = 'Adobe Acrobat Reader' 
   AND Sentiment = 'Negative';  
   


