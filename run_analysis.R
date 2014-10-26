activity_labels = read.table("activity_labels.txt")
names(activity_labels)[2] = "activity"
features = read.table("features.txt")
subject_test = read.table("test/subject_test.txt")
X_test = read.table("test/X_test.txt", col.names=features[,"V2"])
y_test = read.table("test/y_test.txt")

merged_test = read.table("test/subject_test.txt", col.names = c("subject"))
merged_test[, "activity"] = merge(y_test, activity_labels, by="V1")[,"activity"]
merged_test = merge(merged_test, X_test, by=0)

subject_train = read.table("train/subject_train.txt")
X_train = read.table("train/X_train.txt", col.names=features[,"V2"])
y_train = read.table("train/y_train.txt")

merged_train = read.table("train/subject_train.txt", col.names = c("subject"))
merged_train[, "activity"] = merge(y_train, activity_labels, by="V1")[,"activity"]
merged_train = merge(merged_train, X_train, by=0)

merged_total = rbind(merged_test, merged_train)

column_names = features$V2[grep("std|mean", features$V2)]

mean_by_group = aggregate(merged_total[, column_names], list(merged_total$subject, merged_total$activity), mean)

colnames(mean_by_group)[1] = "subject"
colnames(mean_by_group)[2] = "activity"
