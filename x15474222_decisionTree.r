#read data file
mydata=read.csv("Invistico_airline.csv", sep = ',', header = TRUE)

#count she amount of rows with NA data 
sum(is.na(mydata))
#remove rows with NA 
mydata <- na.omit(mydata)

#look at summary of the data catergorised by each column 
summary(mydata)

# Check attributes of the data
str(mydata)

# Check number of rows and columns
dim(mydata)

# Change relevant variables into factor type of data  
mydata$Class = as.factor(mydata$Class)
mydata$Type.of.Travel = as.factor(mydata$Type.of.Travel)
mydata$Customer.Type = as.factor(mydata$Customer.Type)
mydata$Gender = as.factor(mydata$Gender)
mydata$satisfaction = as.factor(mydata$satisfaction) 


# Split data into training (70%) and validation (30%)
set.seed(123)
dt = sort(sample(nrow(mydata), nrow(mydata)*.7))
train<-mydata[dt,]
test <- mydata[-dt,]

# Check number of rows in training and test data set
nrow(train)
nrow(test)

#training the decision tree classifier 
library(rpart)
mtree <- rpart(satisfaction~., 
               data = train, 
               method="class", 
               control = rpart.control
               (minsplit = 20, 
                 minbucket = 7, 
                 maxdepth = 10, 
                 usesurrogate = 2, xval =10 ))

#view summary of the classification tree 
summary(mtree)

#Plot tree - basic version 
plot(mtree)
text(mtree)
#Beautify tree
library(rattle)
library(rpart.plot)
library(RColorBrewer)
#fancy Plot
fancyRpartPlot(mtree)

#Use the decision tree 'mtree' to make predictions of the test data 
treeStatusPredict <- predict(mtree, test, type = 'class')
#confusion matrix for evaluating the model 
library(caret)
confusionMatrix(treeStatusPredict, test$satisfaction)
##Accuracy of this model 86.4%

##Step 6: Improve the tree by pruning
#use the cp table to find the relevant cp value to use for pruning the tree 
printcp(mtree) 
plotcp(mtree)
bestcp <- mtree$cptable[which.min(mtree$cptable[,"xerror"]),"CP"] 
#in this instance the relevant cp value to use is 0.01 
#generate the pruned tree 
pruned_tree <- prune(mtree, cp=0.01)

#plotting the pruned tree
prp(pruned_tree, faclen=0, cex=0.8, extra=1)
#fancy pruned tree
fancyRpartPlot(pruned_tree)

#I noticed that the pruned tree is exactly the same to the original 'mtree'
#I decided to increase the cp value to see if this would create a more accurate model 
pruned_tree2 <- prune(mtree, cp=0.015)
fancyRpartPlot(pruned_tree2)
#Predictions
prunedTree2Predict <- predict(pruned_tree2, test, type = 'class')
#confusion matrix for evaluating the model 
library(caret)
confusionMatrix(prunedTree2Predict, test$satisfaction)
### Accuracy result 84% - lower than the original tree 
##this suggests that the original tree produced produces a higher accuracy 


#Predictions 
prunedTreePrediction <- predict(pruned_tree, test, type = 'class')

#Evaluating the results - with a confusion matrix 
library(caret)
confusionMatrix(prunedTreePrediction, test$satisfaction, positive = 'satisfied')
#Accuracy 86.4% - same as the original tree model 

##OR 
##Confusion Matrix for train data 
conf.matrix <- table(train$satisfaction, predict(pruned_tree, type="class"))
rownames(conf.matrix) <- paste("Actual",rownames(conf.matrix),sep=":")
colnames(conf.matrix) <- paste("Pre",colnames(conf.matrix),sep=":")
conf.matrix


##test data performance to see the generalisability of model
confusionMatrix(predict(pruned_tree, test, type="class"),test$satisfaction)


### ROC Curve
library(ROCR)
val1 <- predict(pruned_tree,test,type="prob")
val1
#Storing model performance scores
pred_val <- prediction(val1[,2],test$satisfaction)
#calculating area under curve
perf_val <- performance(pred_val,"auc")
perf_val
##plot the performance
plot(performance(pred_val,measure="lift",x.measure="rpp"),colorize=TRUE)
###True positive and false positive rate
perf_val <- performance(pred_val, "tpr","fpr")
plot(perf_val, col = "green", lwd= 1.5)


###Step 8: Improving model performance using Random Forest
library(randomForest)
Model<- randomForest(satisfaction~., data= train, mtry=7, ntree=400, importance= TRUE)
##plot random forest 
plot(Model)
##use random forest model to predict against the test data to evaluate performance 
pred.rf <- predict(Model,newdata = test, type="class")
table(test$satisfaction, pred.rf)
confusionMatrix(pred.rf,test$satisfaction)


###### I used the code below to calculat that the optimal vales for the decision tree were 
### 400 tree and an mtry value of 7 
oob.values <- vector(length = 10)
for(i in 1:10){
  temp.model <- randomForest(satisfaction~., data= train, mtry=i, ntree=1000)
  oob.values[i] <- temp.model$err.rate[nrow(temp.model$err.rate),1]
}

oob.values


##### plot to see the optimal number of trees - 400 trees 
oob.error.data <- data.frame(
  Trees=rep(1:nrow(rn_model$err.rate), times=3),
  Type=rep(c("OOB", "satisfied", "dissatisfied"), each=nrow(rn_model$err.rate)),
  Error=c(rn_model$err.rate[,"OOB"], 
          rn_model$err.rate[,"satisfied"], 
          rn_model$err.rate[,"dissatisfied"]))


library(ggplot2)
ggplot(data=oob.error.data, aes(x=Trees, y=Error)) +
  geom_line(aes(color=Type))





