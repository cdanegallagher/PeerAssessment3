#run_analysis.R


#store orignal path to be used for final output
original.dir<-getwd()

#Make temporary directory and unzip file
main.dir<-tempfile()
unzip("getdata-projectfiles-UCI HAR Dataset.zip",exdir = main.dir)
setwd(main.dir)
main.dir<-list.files(main.dir)[1]


test.dir<-paste(main.dir,"\\","test",sep="")
train.dir<-paste(main.dir,"\\","train",sep="")

#load all dataframesfrom all files

df.train.subject<-read.table(paste(train.dir,"\\","subject_train.txt",sep=""))
df.train.y<-read.table(paste(train.dir,"\\","y_train.txt",sep=""))
df.train.x<-read.table(paste(train.dir,"\\","X_train.txt",sep=""))

df.test.subject<-read.table(paste(test.dir,"\\","subject_test.txt",sep=""))
df.test.y<-read.table(paste(test.dir,"\\","y_test.txt",sep=""))
df.test.x<-read.table(paste(test.dir,"\\","X_test.txt",sep=""))

#create activity labels
activity.labels<-c("WALKING","WALKING_UPSTAIRS",
                   "WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")

#get vector of names
features<-scan(paste(main.dir,"\\","features.txt",sep=""),what="character")
features<-features[seq(2,length(features),2)]

#get vector of indices 
indices<-grep("mean\\(\\)|std\\(\\)",features)

#narrow down features to only those with mean() or std()
features<-features[indices]


#concatenate xtest to bottom of xtrain
df.total.x<-rbind(df.train.x,df.test.x)

#remove everythin except for mean() and std() (measurement)
df.total.x<-df.total.x[indices]
colnames(df.total.x)<-features


#contatente subjecttest to bottom of subjecttrain (subject)
df.total.subject<-rbind(df.train.subject,df.test.subject)
colnames(df.total.subject)<-c("subject")


#concatenate y_test to y_train (activity)
df.total.y<-rbind(df.train.y,df.test.y)

#replace numbers with activity labels
colnames(df.total.y)<-c("activity")
for(i in 1:6){
        df.total.y[df.total.y$activity==i,]<-activity.labels[i]
        
}



#horizontoally merge all three dfs to get ffirst data set
df.total<-cbind(df.total.subject,df.total.y,df.total.x)


#aggregate to get mean of each mean and std for each subject/activity pair 
#and to get the second independent data set
tidydata <-aggregate(df.total[,c(3:ncol(df.total))],
                     by=list(subject=df.total$subject,activity=df.total$activity),
                     FUN=mean, na.rm=TRUE)

#return to original directory and output tidydata to file
setwd(original.dir)
write.table(tidydata, file = "tidydata.txt")

