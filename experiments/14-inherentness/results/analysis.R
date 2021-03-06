library(ggplot2)
library(lme4)
library(hydroGOF)
library(tidyr)
library(dplyr)

setwd("~/Documents/git/cocolab/adjective_ordering/experiments/14-inherentness/Submiterator-master")

num_round_dirs = 8
df = do.call(rbind, lapply(1:num_round_dirs, function(i) {
  return (read.csv(paste(
    'round', i, '/inherentness.csv', sep='')) %>%
    #'round', i, '/inherentness-trials.csv', sep='')) %>%
      mutate(workerid = (workerid + (i-1)*9)))}))

#d = subset(df, select=c("workerid", "class","predicate","slide_number","response","condition"))
d = subset(df, select=c("workerid", "class","predicate","noun","slide_number","response","language","condition"))
unique(d$language)
#d = d[d$language!="Chinese"&d$language!="Spanish, English"&d$language!="Spanish"&d$language!="Hindi"&d$language!="spanish"&d$language!="",]
#unique(d$language)

length(unique(d$workerid)) # n=72
table(d$condition)

#write.csv(d,"../results/subjectivity-expanded_results.csv")

inh = d[d$condition=="inherent",]
#write.csv(inh,"../results/inherentness.csv")
sub = d[d$condition=="subjective",]
#write.csv(sub,"../results/subjectivity.csv")

## predicate plot by class
c_s = bootsSummary(data=d, measurevar="response", groupvars=c("class","condition"))
#c_s = aggregate(response~class,data=d,mean)

class_plot <- ggplot(c_s, aes(x=reorder(class,-response,mean),y=response,fill=condition)) +
  geom_bar(stat="identity",position=position_dodge()) +
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(class,response,is.ordered=T), width=0.1),position=position_dodge(width=0.9))+
  ylab("rating\n")+
  xlab("adjective class") +
  #facet_wrap(~class,scale="free_x") +
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))+
  theme_bw()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))
class_plot
#ggsave("../results/class_ratings.pdf",height=3)


## predicate plot by class
p_s = bootsSummary(data=inh, measurevar="response", groupvars=c("class","predicate","noun"))
p_s$predicate <- factor(p_s$predicate,ordered=is.ordered(p_s$predicate))
pred_plot <- ggplot(p_s, aes(x=noun,y=response)) +
  geom_bar(stat="identity",position=position_dodge(),fill="gray",color="darkgray") +
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=noun, width=0.1),position=position_dodge(width=0.9))+
  ylab("inherentness\n")+
  xlab("predicate") +
  facet_wrap(class~predicate,scale="free_x") +
  theme_bw()+
  theme(axis.text.x=element_text(angle=90,vjust=0.5,hjust=1))
pred_plot
ggsave("../results/inh_pred_plot.pdf",height=8, width=9)


s_p_s = bootsSummary(data=sub, measurevar="response", groupvars=c("class","predicate","noun"))
s_pred_plot <- ggplot(s_p_s, aes(x=noun,y=response)) +
  geom_bar(stat="identity",position=position_dodge(),fill="gray",color="darkgray") +
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=noun, width=0.1),position=position_dodge(width=0.9))+
  ylab("subjectivity\n")+
  xlab("predicate") +
  facet_wrap(class~predicate,scale="free_x") +
  theme_bw()+
  theme(axis.text.x=element_text(angle=90,vjust=0.5,hjust=1))
s_pred_plot
ggsave("../results/sub_pred_plot.pdf",height=8, width=9)

summary(s_p_s)
