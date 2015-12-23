#Script Created by Kanishk Asthana
archivePage=readLines("http://www.gencodegenes.org/stats/archive.html")
#Finding gencode version indices
versionIndices=grep("Version\\s[0-9]",archivePage)
versionLine=archivePage[versionIndices]

versionReleasePeriod=sapply(versionLine, function(line){
  #Deleting First part of the String
  line=sub(".*\\(","",line)
  #Deleting Second unwanted part of String
  line=sub("\\sfreeze,\\s.*\\).*","",line)
  print(line)
  return(line)
})
#Storing Names of all Version in a vector
versionReleasePeriod=as.character(versionReleasePeriod)
