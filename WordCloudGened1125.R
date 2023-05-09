#Install text mining package and initalize library
install.packages("tm")
library(tm)

#Establish body of text to pull from (aka "Corpus")
course_corpus <- VCorpus(DirSource("/Users/shanivisrikonda/Desktop/ChatGPT/specific_folder"))
#Convert to minuscule format
course_corpus2 <- tm_map(course_corpus, content_transformer(tolower))
#Delete the punctuation/symbols/etc
course_corpus3 <- tm_map(course_corpus2, removePunctuation)
#Delete the stopwords/etc
course_corpus4 <- tm_map(course_corpus3, removeWords, stopwords("english"))
#Generate TF-IDF matrix
course_dtm <- DocumentTermMatrix(course_corpus4)
#Inspect to TF-IDF
inspect(course_dtm)

#Generate  data frame to establish word frequency for word cloud - shows the word frequency after 
word_frequency <- sort(colSums(as.matrix(course_dtm)),
                       decreasing=TRUE)
df_frequency<- data.frame(word = names(word_frequency),
                          freq=word_frequency)
head(df_frequency)

install.packages("wordcloud")
library(wordcloud)

#Generate a simple word cloud without formatting or number of words specified
wordcloud(df_frequency$word,
          df_frequency$freq)

#Word cloud generated with top ten most frequent words pulled from the text (corpus) body
wordcloud(df_frequency$word,
          df_frequency$freq,
          max.words=10, min.freq = 1)

# References for code cited in the paper

