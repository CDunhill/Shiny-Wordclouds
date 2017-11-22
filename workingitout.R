
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
library (wordcloud2)
library (tm)

#1 Import and clean
data <- read.csv("revs_oct17.csv")
View (data)
# Need to add in MW hierarchy? (later)

#2 Transform by aggregating all reviews into one record per Ref
reviews <- aggregate(ReviewBody ~ Ref, data = data, paste, collapse = ",")

#3 Clean up the data
# ref <- sample (reviews$Ref,1)
# other good refs: 21217 21782 
ref <- 24339
refreview <- reviews$ReviewBody[reviews$Ref==ref]
refreview <- gsub("[[:punct:]]", " ", refreview, except("'"))      # regular expression used :)
refreview <- gsub("null", " ", refreview)
refreview <- gsub("NULL", " ", refreview)

vsrefreview <- VectorSource(refreview) # converts to 

vsrefreview = Corpus(vsrefreview)
vsrefreview = tm_map(vsrefreview, tolower)
# vsrefreview = tm_map(vsrefreview, removePunctuation) - already done with gsub, above
vsrefreview = tm_map(vsrefreview, removeNumbers)
vsrefreview = tm_map(vsrefreview, removeWords, stopwords("english"))

inspect(vsrefreview)

# How do I get the data into word,freq format for wordcloud2 visualisations?
# wordcloud2(myDTM)

# Creates the word, freq list (but in 'TermDocumentMatrix' class - no use for wordcloud2)
tdm <- TermDocumentMatrix(vsrefreview, control = list(removePunctuation = TRUE, stopwords = TRUE))

# convert from TermDocumentMatrix to data.frame
tdm <- data.frame(as.matrix(tdm), stringsAsFactors=FALSE)

# The row names are presently not actually a column so they need to be added as one:
tdm <- cbind(rownames(tdm), tdm)

# Let's plot the wordcloud
# set.seed(1234)
wordcloud2(tdm)

