#Created by Arzu Ozcan

##Purpose - To compile all R codes learnt in ANLY506

###-----------------------------------------------------------------------
### CHAPTER 11 - DATA IMPORT - Week5
###-----------------------------------------------------------------------

library(tidyverse)      # Required package to load flat files
read.csv()              # Reads cvs files - most common function used to read files
read.csv2()             # Reads semicolon separated files ( where , used as the decimal place)
read_tsv()              # Reads tab delimited files
read_delim()            # Reads in files with any delimiter
read_fwf()              # Reads fixed width files
fwf_widths()            # Specify fields by their widths
fwf_positions()         # Specify fields by their position
read_table()            # Reads a common variation of fixed width files where columns are separated by white space
read_log()              # Reads Apache style log files

name<-read_csv("path to the file")  # Gives a name to the file that is read with the path

read_csv("a,b,c     
1,2,3
4,5,6")                 # Prints out a column specification that gives the name and type of each column
                        #> # A tibble: 2 x 3
                        #>       a     b     c
                        #>   <dbl> <dbl> <dbl>
                        #> 1     1     2     3
                        #> 2     4     5     6

read_csv("The first line of metadata
The second line of metadata
x,y,z
1,2,3", skip = 2)       # Use skip = n to skip the first n lines
                        #> # A tibble: 1 x 3
                        #>       x     y     z
                        #>   <dbl> <dbl> <dbl>
                        #> 1     1     2     3

read_csv("# A comment I want to skip
x,y,z
1,2,3", comment = "#")  # Use comment = "#" to drop all lines that start with (e.g.) #
                        #> # A tibble: 1 x 3
                        #>       x     y     z
                        #>   <dbl> <dbl> <dbl>
                        #> 1     1     2     3

read_csv("1,2,3\n4,5,6", col_names = FALSE)   # Use col_names = FALSE to tell read_csv() not to treat the first row as headings, and instead label them sequentially from X1 to Xn:
                                              #> # A tibble: 2 x 3
                                              #>      X1    X2    X3
                                              #>   <dbl> <dbl> <dbl>
                                              #> 1     1     2     3
                                              #> 2     4     5     6

read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z"))  # USe col_names a character vector to name the columns
                                                        #> # A tibble: 2 x 3
                                                        #>       x     y     z
                                                        #>   <dbl> <dbl> <dbl>
                                                        #> 1     1     2     3
                                                        #> 2     4     5     6

read_csv("a,b,c\n1,2,.", na = ".")                      # Use na: this specifies the value (or values) that are used to represent missing values
                                                        #> # A tibble: 1 x 3
                                                        #>       a     b c    
                                                        #>   <dbl> <dbl> <lgl>
                                                        #> 1     1     2 NA

              

str(parse_logical(c("TRUE", "FALSE", "NA")))            # Changes character vector into a logical vector
                                                        #>  logi [1:3] TRUE FALSE NA

str(parse_integer(c("1", "2", "3")))                    # Changes character vector into a integer vector
                                                        #>  int [1:3] 1 2 3

str(parse_date(c("2010-01-01", "1979-10-14")))          # Changes character vector into a date vector
                                                        #>  Date[1:2], format: "2010-01-01" "1979-10-14"

parse_integer(c("1", "231", ".", "456"), na = ".")      # The first argument is a character vector to parse, and the na argument specifies which strings should be treated as missing
                                                        #> [1]   1 231  NA 456

parse_logical()       # Logical parser
parse_integer()       # Integer parser 
parse_double()        # Strict numeric parser 
parse_number()        # Flexible numeric parser
parse_character()     # Character encodings parser
parse_factor()        # Create factors, the data structure that R uses to represent categorical variables with fixed and known values

parse_datetime()      # Parse various date & time specifications
parse_date()
parse_time()       

parse_double("1.23")
                      #> [1] 1.23
parse_double("1,23", locale = locale(decimal_mark = ","))   # Converts "," into "."
                                                            #> [1] 1.23


guess_parser()        # Returns the best guess
parse_guess()         # Uses the best guess to parse the column

write_excel_csv()     # Writes a special character (a “byte order mark”) at the start of the file which tells Excel that you’re using the UTF-8 encoding.
write_csv(challenge, "challenge.csv")


