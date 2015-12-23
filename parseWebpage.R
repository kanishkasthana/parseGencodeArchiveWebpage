#Script Created by Kanishk Asthana to get statistics for previous gencode releases.
archivePage=readLines("http://www.gencodegenes.org/stats/archive.html")
#Finding gencode version indices
versionIndices=grep("Version\\s[0-9]",archivePage)
versionLine=archivePage[versionIndices]

#Storing Names of all Versions in a vector
versionReleasePeriod=as.character(sapply(versionLine, function(line){
  #Deleting First part of the String
  line=sub(".*\\(","",line)
  #Deleting Second unwanted part of String
  line=sub("\\sfreeze,\\s.*\\).*","",line)
  print(line)
  return(line)
}))

#Storing Version Numbers in a vector
versions=as.character(sapply(versionLine, function(line){
  match=regexpr("Version\\s.{1,2}",line)
  versionText=as.character(regmatches(line,match))
  return(versionText)
}))

#Adding 3 because the gene numbers are 3 lines down in the html

#Two different formats in which data is organised so I have to split this operation into 2 parts
totalGenesIndices1=grep("\\sTotal No of Genes",archivePage)+3
#Removing Whitespaces and converting to numeric
totalGenes1=as.numeric(gsub("\\s","",archivePage[totalGenesIndices1]))
#Getting Line numbers for second format
totalGeneIndices2=grep("<dt>Total No of Genes",archivePage)+1
totalGenes2Lines=archivePage[totalGeneIndices2]
totalGenes2=as.numeric(sapply(totalGenes2Lines,function(line){
  #Removing HTML tags
  line=gsub("<.{2,3}>","",line)
  #Removing whitespace
  line=gsub("\\s","",line)
  print(line)
  return(line)
}))
#Combinging Total Genes into a single vector
totalGenes=c(totalGenes1,totalGenes2)
svg("TotalGenesPlot.svg")
plot(rev(totalGenes), type = 'l', xaxt="n", xlab="Release Version", ylab="Total Genes", main="Plot of Total Human Genes with Version Number")
axis(1, at=1:length(totalGenes), labels=rev(versions))
plot(rev(totalGenes), type = 'l', xaxt="n", xlab="Time of release", ylab="Total Genes", main="Plot of Total Human Genes with Time of Release")
axis(1, at=1:length(totalGenes), labels=rev(versionReleasePeriod))
dev.off()