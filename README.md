# FMF

Tools to parse complex formatted model files in R.

Many ecological models, such as APEX, use text files to hold the input parameters and the results.

These files are often formatted with a mixture of fixed-width and delimited fields, have rows of differing lengths, etc, which makes it difficult to import them into R for automatically setting up runs and for analysis.

These R tools will read and write complex text files, facilitating sensitivity analysis, automation, etc.

Capabilities include:

- specifying the model file format, including:
    - fixed width and delimited fields.
    - field justification.
    - decimal places.
    - constraints on contents such as range of values.
- importing these files into R as lists of data frames.
    - each different section of the file, such as header and body, is a new data frame.
- checking whether fields satisfy constraints.
- writing R objects to formatted text files.

