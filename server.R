library(shiny)
library(tm)
library(wordcloud)

shinyServer(function(input,output,session) {
  
  wc_data <- reactive({
    
    input$update
    
    isolate({
      withProgress({
        setProgress(message = "processing corpus...")
        wc_file <- input$wc
        if(!is.null(wc_file)) {
          wc_text <- readLines(wc_file$datapath)
        }
        else
        {
          wc_text <- "A word cloud is an image made of words that together resemble a cloudy shape.
          The size of the word shows how important it is.People typically use word clouds to easily produce a summary of large documents"}
        
        wc_corpus <- Corpus(VectorSource(wc_text))
        wc_corpus_clean <- tm_map(wc_corpus, tolower)
        wc_corpus_clean <- tm_map(wc_corpus_clean, removeNumbers)
        wc_corpus_clean <- tm_map(wc_corpus_clean, removeWords, stopwords())
        wc_corpus_clean <- tm_map(wc_corpus_clean, stripWhitespace)
        wc_corpus_clean <- tm_map(wc_corpus_clean,stemDocument)
        
        })
    })
})
  
wordcloud_rep <- repeatable(wordcloud)

output$wcplot <- renderPlot({
  withProgress({
    setProgress(message = "Creating Wordcloud...")
    wc_corpus <- wc_data()
    wc_color = brewer.pal(8,"Set2")
    if(input$color == "Accent"){
      wc_color = brewer.pal(8,"Accent")
  }
  else {
    wc_color = brewer.pal(8,"Dark2")  }
    wordcloud(wc_corpus,min.freq =input$wordfreq,max.words = input$maxword, colors =wc_color,random.order = FALSE,rot.per = .30)
     })
  })
})

