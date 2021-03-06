setwd("~/Documents/git/cocolab/adjective_ordering/experiments/12-order-preference-expanded/Submiterator-master")
source("../results/helpers.R")

agr = read.csv("order-preference-duplicated.csv",header=T)

length(unique(agr$correct_configuration)) #4084

ggplot(data=agr,aes(x=reorder(correctclass1,-correctresponse,mean),y=correctresponse,fill=makes_sense,color=makes_sense))+
  geom_violin(alpha=.5)+
  geom_point(alpha=1,position=position_dodge(.9))+
  xlab("class")+
  ylab("response\n")+
  theme_bw()+
  theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))
#ggsave("../results/class_distance_violin.pdf",height=3)

agr_s = bootsSummary(data=agr[agr$makes_sense=="yes",], measurevar="correctresponse", groupvars=c("correctclass1"))
#all_agg_s = aggregate(correctresponse~correctclass1*makes_sense,data=agr,mean)

ggplot(data=agr_s,aes(x=reorder(correctclass1,-correctresponse,mean),y=correctresponse))+
  geom_bar(stat="identity",position=position_dodge())+
  geom_errorbar(aes(ymin=bootsci_low, ymax=bootsci_high, x=reorder(correctclass1,-correctresponse,mean), width=0.2),alpha=0.8,position=position_dodge(.9))+
  xlab("adjective class")+
  ylab("rating\n")+
  ylim(0,1)+
  #labs("order\npreference")+
  theme_bw()+
theme(axis.text.x=element_text(angle=45,vjust=1,hjust=1))
#ggsave("../results/preferred_class_distance.pdf",height=3)