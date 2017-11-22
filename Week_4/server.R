
library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  marketcloseexists <- reactive ({
    datetoplot<-input$date
    marketcloseinmydate<-as.numeric(GSPC[,6][datetoplot])
    if(identical(marketcloseinmydate, numeric(0))){
      newdate<-as.Date(datetoplot)-1
      if (identical(as.numeric(GSPC[,6][newdate]), numeric(0))){
        datetoplot<-as.Date(datetoplot)+1
      } else {
        datetoplot<-newdate
      }
    }
    return(datetoplot)
  })
   
   
  output$dynamicyieldcurve <- renderPlot({
    
    datetoplotline<-marketcloseexists()
    #capture cases where there's a market close but the FED closed and didn't update
    #their datasets
    if(datetoplotline>lastdayir){
      datetoplotline<-lastdayir
    }
    
    #Fill up interest rates
    for (i in 1:length(names(interestrates))){
      interestrates[i] <- as.numeric(env[[names(interestrates)[i]]][datetoplotline])
    }
    g_range <- range(0, interestrates)
    
    plot(interestrates, type="l", pch=16, 
         xlab=c("Interest Rates At Different Maturity"), 
         ylab="Interest Rates (%)", 
         xaxt='n', ylim = c(0,6),  log = "x")
    legend("bottomright", g_range[2], datetoplotline, cex = 0.8)
    axis(1, at=1:8, las=2, lab=c("3MO", "1YR", "2YR", "5YR", "7YR", "10YR", "20YR", "DGS30"))
    #axis(2, las=1, at=4*0:g_range[2])
    box()
    title(main="Dynamic Yield Curve", col.main="red", font.main=4)
    
  })
  
  output$market <- renderPlot({
    mydate<-as.character(input$date)
    datetoplotline<-marketcloseexists()
    
    plot.ts(x=marketopendays, y=GSPC[,6], ylab="S&P", xlab=c("Date"), type='l',ylim=c(minclose, maxclose))
    #axis(1, at=marketopendays, las=2, cex.axis=0.85 )
    abline(v=as.Date(datetoplotline), col="red", lwd=3, lty=2)
    legend("topleft", as.character(datetoplotline), cex = 0.8)
    })
  
  
})
