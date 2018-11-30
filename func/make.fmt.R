make.fmt <- function(rfmt.in) {
	# take a character vector and identify the most probable format information for each element
	# returns vector containing number of decimal places of each field 
	#   "c" for char or "i" for integer
	# this function can't identify round-to-fit fields or character fields that appear numeric,
	# like zip codes
	# but can provide a useful starting place

	if(is.character(rfmt.in)) {
		# extract decimal places
		rfmt <- rep("c", length.out=length(rfmt.in))
		for(i in seq_along(rfmt)) {
			# if can be converted to numeric, extract number of decimal places
			# otherwise leave that value as NA
			if(is.numeric(type.convert(rfmt.in[i]))) {
				if(grepl("\\.", rfmt.in[i])) {
					if(grepl("\\.$", rfmt.in[i])) {
						rfmt[i] <- "0"
					} else {
						rfmt[i] <- nchar(strsplit(as.character(rfmt.in[i]), "\\.")[[1]][2])
					}
				} else {
						rfmt[i] <- "i"
				}
			}
		}
	}
	rfmt
}

