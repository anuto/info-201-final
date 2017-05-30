CleanZip <- function(zip) {
  zip.length <- stri_length(as.character(zip))
  if (zip.length > 5) {
    diff <- zip.length - 5
    zip <-trunc((zip / (10 ^ diff)), prec = -2)
    
  }
  return(zip)
}