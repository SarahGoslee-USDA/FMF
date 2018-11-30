print.section <- function(desc, secno) {
    # display a nicely formatted table
    # will take a section directly, or a full description object

    if(names(desc)[1] == "rowspec") {
        # full description object
        thissec <- desc$rowspec[[secno]]
    } else { 
        # assume is a single section
        thissec <- desc
    }

    with(thissec, data.frame(Field = names, Format = fmt, Justification = just, Constraint = constraints$ctype, CValues = do.call(paste, list(constraints$cval, sep=", ")), Details = fielddoc))

}


