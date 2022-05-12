# Data-Mining-Project
Correlation between Movie Ratings and Gross Revenue


In the world of entertainment, everyone wants to know how well a movie will perform
at the box-office even before its release. With machine learning, it is possible to find a solution
for this problem if the gross revenue of a movie is correlated with other variables. In this paper,
our goal was to check if there is indeed correlation between movie ratings, reviews, and other
variables such as runtime, year of release etc. to the gross revenue that a movie will obtain. The
dataset that we considered included information from the top 1000 rated movies on IMDb.
Before building our models, we found that critics’ ratings don’t have much of an impact on the
revenue of movies. We have used classification algorithms such as k-NN and Adaboost to
check for optimal performance after discretizing our target variable based on median. With
Adaboost on R, we were able to correctly predict almost 85% of the time if a movie will bring
in revenue below, or equal or above, the median gross revenue in the dataset.
