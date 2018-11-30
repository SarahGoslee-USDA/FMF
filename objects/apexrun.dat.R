### 2.1 APEXRUN.DAT

## free format file with indeterminate number of lines with 7 fields, and a
## terminal row 

apexrun.desc <- make.desc(
    make.section(rep(NA, 7), rfmt=c("c", rep("i", 6)), rdoc="run configuration", rnames=c("ASTN", "ISIT", "IWPM", "IWND", "ISUB", "ISOL", "IRFT"), times=NA, delim=" "),
    terminal = "XXXXXXXX   0   0   0   0   0",
    doc = "APEX APEXRUN.DAT 2016-05-11")


