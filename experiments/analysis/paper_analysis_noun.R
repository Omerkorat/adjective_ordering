library(hydroGOF)
library(ggplot2)

setwd("~/Documents/git/cocolab/adjective_ordering/experiments/analysis")

# Bootstrap 95% CI for R-Squared
library(boot)
# function to obtain R-Squared from the data 
rsq <- function(formula, data, indices) {
  d <- data[indices,] # allows boot to select sample 
  fit <- lm(formula, data=d)
  return(summary(fit)$r.square)
} 

source("splithalf.R")

#############################################
## load in order preference data
#############################################
o = read.csv("~/Documents/git/cocolab/adjective_ordering/experiments/analysis/naturalness-duplicated.csv",header=T)
head(o)
o_agr_pred = aggregate(correctresponse~predicate*correctclass*nounclass,data=o,mean)
o_agr_class = aggregate(correctresponse~correctclass*nounclass,data=o,mean)
head(o_agr_pred)
head(o_agr_class)
#o_agr_pred = read.csv("~/Documents/git/cocolab/adjective_ordering/experiments/analysis/average-naturalness.csv",header=T)

####### adjclass by nounclass plot
o_agr_class <- bootsSummary(data=o, measurevar="correctresponse", groupvars=c("correctclass","nounclass"))
ggplot(data=o_agr_class,aes(x=reorder(correctclass,-correctresponse,mean),y=correctresponse,fill=nounclass))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(correctclass,-correctresponse,mean), width=0.1),alpha=0.5,position=position_dodge(.9))+
  xlab("\nadjective class")+
  ylab("naturalness rating\n(distance from noun)\n")+
  ylim(0,1)+
  #labs("order\npreference")+
  theme_bw()#+
#ggsave("o_class-by-nounclass.png",height=3)  
####### adjclass by noun plot
o_agr_noun <- bootsSummary(data=o, measurevar="correctresponse", groupvars=c("correctclass","noun","nounclass"))
ggplot(data=o_agr_noun,aes(x=reorder(correctclass,-correctresponse,mean),y=correctresponse,fill=noun))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(correctclass,-correctresponse,mean), width=0.1),alpha=0.5,position=position_dodge(.9))+
  xlab("\nadjective class")+
  ylab("naturalness rating\n(distance from noun)\n")+
  ylim(0,1)+
  #labs("order\npreference")+
  theme_bw()#+
#ggsave("o_class-by-noun.png",height=3)  
####### adj by nounclass plot
o_agr_pred <- bootsSummary(data=o, measurevar="correctresponse", groupvars=c("predicate","correctclass","nounclass"))
ggplot(data=o_agr_pred,aes(x=reorder(predicate,-correctresponse,mean),y=correctresponse,fill=nounclass))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(predicate,-correctresponse,mean), width=0.1),alpha=0.5,position=position_dodge(.9))+
  xlab("\nadjective")+
  ylab("naturalness rating\n(distance from noun)\n")+
  ylim(0,1)+
  #facet_wrap(~correctclass)+
  #labs("order\npreference")+
  theme_bw()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))
#ggsave("o_predicate-by-nounclass.png",width=8,height=3)  
####### adj by noun plot
o_agr_pred_noun <- bootsSummary(data=o, measurevar="correctresponse", groupvars=c("predicate","correctclass","nounclass","noun"))
ggplot(data=o_agr_pred_noun,aes(x=reorder(predicate,-correctresponse,mean),y=correctresponse,fill=noun))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(predicate,-correctresponse,mean), width=0.1),position=position_dodge(.9))+
  xlab("\nadjective")+
  ylab("naturalness rating\n(distance from noun)\n")+
  ylim(0,1)+
  facet_wrap(~correctclass,scales="free_x")+
  #labs("order\npreference")+
  theme_bw()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))
#ggsave("o_predicate-by-noun.png",height=6,width=12)  


#############################################
## load in faultless
#############################################
f = read.csv("faultless_results.csv",header=T)
head(f)
f_agr_pred = aggregate(response~predicate,data=f,mean)
f_agr_class = aggregate(response~class,data=f,mean)

####### adjclass by nounclass plot
f_agr_class <- bootsSummary(data=f, measurevar="response", groupvars=c("class","nounclass"))
ggplot(data=f_agr_class,aes(x=reorder(class,-response,mean),y=response,fill=nounclass))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(class,-response,mean), width=0.1),alpha=0.5,position=position_dodge(.9))+
  xlab("\nadjective class")+
  ylab("faultless disagreement\n")+
  ylim(0,1)+
  #labs("order\npreference")+
  theme_bw()#+
#ggsave("f_class-by-nounclass.png",height=3)  
####### adjclass by noun plot
f_agr_noun <- bootsSummary(data=f, measurevar="response", groupvars=c("class","noun","nounclass"))
ggplot(data=f_agr_noun,aes(x=reorder(class,-response,mean),y=response,fill=noun))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(class,-response,mean), width=0.1),alpha=0.5,position=position_dodge(.9))+
  xlab("\nadjective class")+
  ylab("faultless disagreement\n")+
  ylim(0,1)+
  #labs("order\npreference")+
  theme_bw()#+
#ggsave("f_class-by-noun.png",height=3)  
####### adj by nounclass plot
f_agr_pred <- bootsSummary(data=f, measurevar="response", groupvars=c("predicate","class","nounclass"))
ggplot(data=f_agr_pred,aes(x=reorder(predicate,-response,mean),y=response,fill=nounclass))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(predicate,-response,mean), width=0.1),alpha=0.5,position=position_dodge(.9))+
  xlab("\nadjective")+
  ylab("faultless disagreement\n")+
  ylim(0,1)+
  #facet_wrap(~class)+
  #labs("order\npreference")+
  theme_bw()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))
#ggsave("f_predicate-by-nounclass.png",width=8,height=3)  
####### adj by noun plot
f_agr_pred_noun <- bootsSummary(data=f, measurevar="response", groupvars=c("predicate","class","nounclass","noun"))
ggplot(data=f_agr_pred_noun,aes(x=reorder(predicate,-response,mean),y=response,fill=noun))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(predicate,-response,mean), width=0.1),position=position_dodge(.9))+
  xlab("\nadjective")+
  ylab("faultless disagreement\n")+
  ylim(0,1)+
  facet_wrap(~class,scales="free_x")+
  #labs("order\npreference")+
  theme_bw()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))
#ggsave("f_predicate-by-noun.png",height=6,width=12)  



#############################################
## load in subjectivity
#############################################
s = read.csv("subjectivity_results.csv",header=T)
head(s)
s_agr_pred = aggregate(response~predicate,data=s,mean)
s_agr_class = aggregate(response~class,data=s,mean)

####### adjclass by nounclass plot
s_agr_class <- bootsSummary(data=s, measurevar="response", groupvars=c("class","nounclass"))
ggplot(data=s_agr_class,aes(x=reorder(class,-response,mean),y=response,fill=nounclass))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(class,-response,mean), width=0.1),alpha=0.5,position=position_dodge(.9))+
  xlab("\nadjective class")+
  ylab("subjectivity\n")+
  ylim(0,1)+
  #labs("order\npreference")+
  theme_bw()#+
#ggsave("s_class-by-nounclass.png",height=3)  
####### adjclass by noun plot
s_agr_noun <- bootsSummary(data=s, measurevar="response", groupvars=c("class","noun","nounclass"))
ggplot(data=s_agr_noun,aes(x=reorder(class,-response,mean),y=response,fill=noun))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(class,-response,mean), width=0.1),alpha=0.5,position=position_dodge(.9))+
  xlab("\nadjective class")+
  ylab("subjectivity\n")+
  ylim(0,1)+
  #labs("order\npreference")+
  theme_bw()#+
#ggsave("s_class-by-noun.png",height=3)  
####### adj by nounclass plot
s_agr_pred <- bootsSummary(data=s, measurevar="response", groupvars=c("predicate","class","nounclass"))
ggplot(data=s_agr_pred,aes(x=reorder(predicate,-response,mean),y=response,fill=nounclass))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(predicate,-response,mean), width=0.1),alpha=0.5,position=position_dodge(.9))+
  xlab("\nadjective")+
  ylab("subjectivity\n")+
  ylim(0,1)+
  #facet_wrap(~class)+
  #labs("order\npreference")+
  theme_bw()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))
#ggsave("s_predicate-by-nounclass.png",width=8,height=3)  
####### adj by noun plot
s_agr_pred_noun <- bootsSummary(data=s, measurevar="response", groupvars=c("predicate","class","nounclass","noun"))
ggplot(data=s_agr_pred_noun,aes(x=reorder(predicate,-response,mean),y=response,fill=noun))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(predicate,-response,mean), width=0.1),position=position_dodge(.9))+
  xlab("\nadjective")+
  ylab("subjectivity\n")+
  ylim(0,1)+
  facet_wrap(~class,scales="free_x")+
  #labs("order\npreference")+
  theme_bw()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))
#ggsave("s_predicate-by-noun.png",height=6,width=12) 


#############################################
## compare subjectivity and subjectivity-noun
#############################################
## order preference
o = read.csv("~/Documents/git/cocolab/adjective_ordering/experiments/analysis/naturalness-duplicated.csv",header=T)
head(o)
o_agr_pred = aggregate(correctresponse~predicate*correctclass,data=o,mean)
o_agr_class = aggregate(correctresponse~correctclass,data=o,mean)
## load in subjectivity
s = read.table("~/Documents/git/cocolab/adjective_ordering/experiments/6-subjectivity/Submiterator-master/subjectivity-trials.tsv",sep="\t",header=T)
s_sub = read.table("~/Documents/git/cocolab/adjective_ordering/experiments/6-subjectivity/Submiterator-master/subjectivity-subject_information.tsv",sep="\t",header=T)
s$language = s_sub$language[match(s$workerid,s_sub$workerid)]
s = s[s$language!="Bosnian"&s$language!="Russian",]
head(s)
s$noun = NA
s$nounclass = NA
s$expt = "nonoun"
s_agr_pred = aggregate(response~predicate,data=s,mean)
s_agr_class = aggregate(response~class,data=s,mean)
# PREDICATE
o_agr_pred$subjectivity = s_agr_pred$response[match(o_agr_pred$predicate,s_agr_pred$predicate)]
gof(o_agr_pred$correctresponse,o_agr_pred$subjectivity) # r = .92, r2 = .85
results <- boot(data=o_agr_pred, statistic=rsq, R=10000, formula=correctresponse~subjectivity)
boot.ci(results, type="bca") # 95%   ( 0.7445,  0.9030 )  
# CLASS
o_agr_class$subjectivity = s_agr_class$response[match(o_agr_class$correctclass,s_agr_class$class)]
gof(o_agr_class$correctresponse,o_agr_class$subjectivity) # r = .92, r2 = .85
results <- boot(data=o_agr_class, statistic=rsq, R=10000, formula=correctresponse~subjectivity)
boot.ci(results, type="bca") # 95%   ( 0.2336,  0.9598 )    
# plot order preference against subjectivity
ggplot(o_agr_pred, aes(x=subjectivity,y=correctresponse)) +
  geom_point() +
  geom_smooth(method=lm,color="black") +
  xlab("\nsubjectivity (no noun; r = 0.92)")+
  ylab("naturalness\n")+
  ylim(0,1)+
  #scale_y_continuous(breaks=c(.25,.50,.75))+
  theme_bw()
#ggsave("naturalness-subjectivity-no-noun.png",height=3,width=4)

## load in subjectivity-noun
sn = read.table("~/Documents/git/cocolab/adjective_ordering/experiments/7-subjectivity-noun/Submiterator-master/subjectivity-trials.tsv",sep="\t",header=T)
sn_sub = read.table("~/Documents/git/cocolab/adjective_ordering/experiments/7-subjectivity-noun/Submiterator-master/subjectivity-subject_information.tsv",sep="\t",header=T)
head(sn)
sn$workerid = paste("sn",sn$workerid)
sn$expt = "noun"
s_agr_pred = aggregate(response~predicate,data=sn,mean)
s_agr_class = aggregate(response~class,data=sn,mean)
# PREDICATE
o_agr_pred$subjectivity = s_agr_pred$response[match(o_agr_pred$predicate,s_agr_pred$predicate)]
gof(o_agr_pred$correctresponse,o_agr_pred$subjectivity) # r = .90, r2 = .81
results <- boot(data=o_agr_pred, statistic=rsq, R=10000, formula=correctresponse~subjectivity)
boot.ci(results, type="bca") # 95%   ( 0.6684,  0.8856 )  
# CLASS
o_agr_class$subjectivity = s_agr_class$response[match(o_agr_class$correctclass,s_agr_class$class)]
gof(o_agr_class$correctresponse,o_agr_class$subjectivity) # r = .90, r2 = .82
results <- boot(data=o_agr_class, statistic=rsq, R=10000, formula=correctresponse~subjectivity)
boot.ci(results, type="bca") # 95%   ( 0.0138,  0.9392 )    
# plot order preference against subjectivity
ggplot(o_agr_pred, aes(x=subjectivity,y=correctresponse)) +
  geom_point() +
  geom_smooth(method=lm,color="black") +
  xlab("\nsubjectivity (with noun; r = 0.90)")+
  ylab("naturalness\n")+
  ylim(0,1)+
  #scale_y_continuous(breaks=c(.25,.50,.75))+
  theme_bw()
#ggsave("naturalness-subjectivity-noun.png",height=3,width=4)




#############################################
## compare faultless and order preference with noun
#############################################
o = read.csv("~/Documents/git/cocolab/adjective_ordering/experiments/analysis/naturalness-duplicated.csv",header=T)
head(o)

#### without noun info
o_agr_pred = aggregate(correctresponse~predicate*correctclass,data=o,mean)
o_agr_class = aggregate(correctresponse~correctclass,data=o,mean)
head(o_agr_pred)
head(o_agr_class)
## faultless
f = read.csv("faultless_results.csv",header=T)
head(f)
f_agr_pred = aggregate(response~predicate*class,data=f,mean)
f_agr_class = aggregate(response~class,data=f,mean)
gof(o_agr_pred$correctresponse,f_agr_pred$response) # r = 0.94, r2 = 0.88
gof(o_agr_class$correctresponse,f_agr_class$response) # r = 0.93, r2 = 0.86

#### with noun info
o_agr_pred = aggregate(correctresponse~predicate*correctclass*noun,data=o,mean)
o_agr_class = aggregate(correctresponse~correctclass*noun,data=o,mean)
head(o_agr_pred)
head(o_agr_class)
o_agr_pred$pred_noun = paste(o_agr_pred$predicate,o_agr_pred$noun)
o_agr_class$class_noun = paste(o_agr_class$correctclass,o_agr_class$noun)
## faultless
f = read.csv("faultless_results.csv",header=T)
head(f)
f_agr_pred = aggregate(response~predicate*class*noun,data=f,mean)
f_agr_class = aggregate(response~class*noun,data=f,mean)
f_agr_pred$pred_noun = paste(f_agr_pred$predicate,f_agr_pred$noun)
f_agr_class$class_noun = paste(f_agr_class$class,f_agr_class$noun)
o_agr_pred$faultless = f_agr_pred$response[match(o_agr_pred$pred_noun,f_agr_pred$pred_noun)]
o_agr_class$faultless = f_agr_class$response[match(o_agr_class$class_noun,f_agr_class$class_noun)]

gof(o_agr_pred$correctresponse,o_agr_pred$faultless) # r = 0.67, r2 = 0.45
gof(o_agr_class$correctresponse,o_agr_class$faultless) # r = 0.83, r2 = 0.68