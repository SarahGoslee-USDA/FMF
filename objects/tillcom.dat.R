### TILLCOM.DAT

# row from the body of a TILLCOM.DAT file to pull formatting from
samplerow <- "    1 TR2W40LP POWE  16237.  17861.    320.  12000.     30.   0.300   0.000   0.007   2.000   0.100   0.680   0.680   0.920   0.000   0.000   0.000   0.000   0.000   0.000   0.000   0.000   0.000   4.000   0.000   0.000   0.000   0.000   0.000   0.000              TRACTOR 2WD  40 HP  LP  "

samplefmt <- make.fmt(read.row(thisrow=samplerow, c(1, 4, 1, 8, 1, 4, rep(8, 29), NA)))

# this creates a file description for the tillage file
tillcom.desc <- make.desc(
  make.section(c(1, 17, rep(8, 30)), c("c", "c", rep("i", 30)), rep("r", 32), rdoc="header1: column numbers"),  
  make.section(c(1, 4, 1, 8, 1, 4, rep(8, 30)), rjust=c("r", "r", "r", "l", rep("r", 32)), rdoc="header2: column names"), 
  make.section(c(1, 4, 1, 8, 1, 4, rep(8, 29), NA), 
    rfmt = samplefmt, rdoc="body: tillage parameters", times=NA),
  doc = "APEX TILLCOM.DAT 2016-05-11"
) 

rm(samplerow, samplefmt)

