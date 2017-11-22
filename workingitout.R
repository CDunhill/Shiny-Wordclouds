
# Plan...
# 1. Import the data - add in MW hierarchy info and description?
# 2. Transform the data into format suitable for wordcloud
# 3. Create wordcloud for a given T2T
# 4. Convert to Shiny app, allowing users to select ref code (or description?)
# 5. Publish Shiny app to users (somehow)

# Some tutorials
# The 'tm' part of this script is based on this blog: https://pirategrunt.wordpress.com/2013/12/11/24-days-of-r-day-11/
# Merging data frames: https://rpubs.com/NateByers/Merging # not actually used this yet

library (wordcloud)
library (tm)

#1 Import and clean
data <- read.csv("revs_oct17.csv")
View (data)
# Need to add in MW hierarchy? (later)


#2 Transform by aggregating all reviews into one record per Ref
reviews <- aggregate(ReviewBody ~ Ref, data = data, paste, collapse = ",")

#3 Create wordcloud for given (random, here) T2T
ref <- sample (reviews$Ref,1)
refreview <- reviews$ReviewBody[reviews$Ref==ref]
refreview <- gsub("[[:punct:]]", " ", refreview, except("'")) # regular expression used :)
refreview <- gsub("null", " ", refreview)
refreview <- gsub("NULL", " ", refreview)

vsrefreview <- VectorSource(refreview) # converts to 

vsrefreview = Corpus(vsrefreview)
vsrefreview = tm_map(vsrefreview, tolower)
# vsrefreview = tm_map(vsrefreview, removePunctuation) - already done with gsub, above
vsrefreview = tm_map(vsrefreview, removeNumbers)
vsrefreview = tm_map(vsrefreview, removeWords, stopwords("english"))

inspect(vsrefreview)

myDTM = TermDocumentMatrix(vsrefreview, control = list(minWordLength = 1))
m = as.matrix(myDTM)
v = sort(rowSums(m), decreasing = TRUE)
library(wordcloud)
pal <- brewer.pal(8,"Dark2")
set.seed(1234) # for reproducibility
wordcloud(names(v), v, colors=pal)

# How do I get the data into word,freq format for wordcloud2 visualisations?
# wordcloud2(myDTM)











