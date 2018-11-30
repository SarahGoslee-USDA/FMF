check.constraints <- function(x, desc) {
    # check whether the fields satisfy pre-specified constraints, if any

    results <- matrix(NA, nrow=0, ncol=4)

    for(thissecno in seq_along(desc$rowspec)) {
        thissection <- x[[thissecno]]
        ctype <- desc$rowspec[[thissecno]]$constraints$ctype
        cval  <- desc$rowspec[[thissecno]]$constraints$cval

        for(thisrowno in seq_len(nrow(thissection))) {
            thisrow <- thissection[thisrowno, ]
            for(thisfieldno in seq_along(thisrow)) {
                if(!is.na(thisrow[thisfieldno]) & !is.na(ctype[thisfieldno])) {
                    if(ctype[thisfieldno] == "r") {
                        thischeck <- thisrow[thisfieldno] >= cval[[thisfieldno]][1] & thisrow[thisfieldno] <= cval[[thisfieldno]][2]
                    } else {
                        thischeck <- thisrow[thisfieldno] %in% cval[[thisfieldno]]
                    }

                    if(!thischeck) {
                        # Could add doc strings to this
                        results <- rbind(results, c(thissecno, thisrowno, thisfieldno, thisrow[thisfieldno]))
                    }
                }
            }
        }
    }

    if(nrow(results) > 0) {
        results <- data.frame(results)
        colnames(results) <- c("Section", "Row", "Field", "Problem value")
    } else {
        results <- "Passes!"
    }

    results

}

    

