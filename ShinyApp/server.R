library(shiny)
library("ggplot2")
shinyServer(function(input, output){

        output$distPlot<-reactivePlot(function(){
                maxc<-input$N
                alpha<-1-input$a/100;beta<-input$b/100
                upper<-input$AQL;lower<-input$RQL
                num<-seq(10,maxc,by=10)
                q1<-qbinom(p=alpha, size=num, prob=upper)
                q2<-qbinom(p=beta, size=num, prob=lower)
                dq<-q1-q2
                for(i in 1:length(dq)){
                        if (dq[i]<0) break
                }
                if(i>=length(dq)){ i<-length(dq)-1}
                num1<-num[i]
                num<-seq(num1-10,num1+10,by=1)
                q1<-qbinom(p=alpha, size=num, prob=upper)
                q2<-qbinom(p=beta, size=num, prob=lower)
                dq<-q1-q2
                for(i in 1:length(dq)){
                        if (dq[i]<0) break
                }
                q0<-q1[i]
                num0<-num[i]
                p<-seq(0,1,by=0.005)
                p0<-pbinom(q=q0, size=num0, prob=p, log = FALSE)
                pp0<-data.frame(p,p0)
                g<-ggplot(pp0,aes(p,p0))+geom_line(color="blue")
                g<-g+geom_vline(xintercept=c(upper,lower),color="orange",alpha=0.7)
                g<-g+geom_hline(yintercept=c(alpha,beta),color="green",alpha=0.7)
                g<-g+labs(title = "OC curve")
                g<-g+geom_text(x=max(lower,.18),y=max(p0)/2,
                               label =paste("upper =" ,sprintf("%2.3f", upper),", lower =",sprintf("%2.3f",lower)))
                g<-g+geom_text(x=max(p)/2,y=alpha+0.05,label =paste("c/n =",q0,"/", num0))
                g
        })

})
