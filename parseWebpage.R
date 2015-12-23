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
