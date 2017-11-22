
# Plan...
# 1. Import the data - add in MW hierarchy info and description?
# 2. Transform the data into format suitable for wordcloud
# 3. Create wordcloud for a given T2T
# 4. Convert to Shiny app, allowing users to select ref code (or description?)
# 5. Publish Shiny app to users (somehow)

# Some tutorials
# Merging data frames https://rpubs.com/NateByers/Merging

library (wordcloud)

#1 Import and clean

data <- read.csv("revs_oct17.csv")
View (data)
# Need to add in MW hierarchy (later)


#2 Transform by aggregating all reviews into one record per Ref

reviews <- aggregate(ReviewBody ~ Ref, data = data, paste, collapse = ",")















