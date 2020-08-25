
## AIm is to create a function that takes a condition and a State to give the best hospital in the state.


best<- function(state=as.character(),op=as.character()){

  filename <- "rprog_data_ProgAssignment3-data.zip"
  state<- readline("Please enter state required (only abbreviations): ")
  op<- readline("Please enter outcome (only heart attack, heart failure and pneumonia): ")
  ##Downloading file as required

  if (!file.exists(filename)){
    c<- readline("You don't have the required dataset, to download press Y: ")
    if(c == "Y"){
    fileURL <- "https://d396qusza40orc.cloudfront.net/rprog%2Fdata%2FProgAssignment3-data.zip"
    download.file(fileURL, filename, method="curl")
    }
    if(c != "Y"){
      stop("File not Downloaded!")
    }
  }

  if (!file.exists("outcome-of-care-measures.csv")) {
    unzip(filename)
  }

  outcome<- read.csv("outcome-of-care-measures.csv")
  state<- toupper(state)

  ## Redundancy if entered state is wrong
  chosen_state<- state
  if (is.element(chosen_state,unique(outcome[["State"]])) == FALSE ){
    stop("invalid state")

  }
  if (is.element(op,c("heart attack", "heart failure", "pneumonia")) == FALSE){
    stop("invalid outcome")

  }

  required_data<- subset(outcome,outcome$State==chosen_state)

  ##Using correct format for data i.e. First letter cap

  p<- strsplit(op," ")[[1]]

  o<- paste(toupper(substring(p,1,1)), substring(p,2), sep = "", collapse= ".")


  desired_outcome<- paste0("Hospital.30.Day.Death..Mortality..Rates.from.",o)

  ## Subsetting data for required data
  req_hospital<- required_data[desired_outcome]

  req_hospital<- req_hospital[!is.na(req_hospital)]
 suppressWarnings( index<-which.min(req_hospital))

  Hospital<- required_data$Hospital.Name[index]

  Hospital
}
