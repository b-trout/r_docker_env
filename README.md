# r_docker: R docker environment for table data analysis

## About this repository
* With files on this repository, you can create docker image for table data analysis using R.  
* From this image, you will get reproducible R environment on which you can handle data loading, wrangling, visualizing, modeling and creating reports.
* Popular statistics or ML libraries (all libraries on lib_names.csv, such as lightgbm, prophet rstan, etc.) are installed.

## How to use
* When you build the image, run the command ```docker-compose build r```. 
* After build, run the command ```docker-compose run --rm -p 8787:8787 r```.
* Libraries listed on lib_names.csv are installed when you build the image. When you want to add or remove libraries, please edit the csv file.

## Note
* If you build with initial lib_names.csv, it takes long time. Please remove unneed library name from the file when you want to build fast.
* The version of almost all of libraries listed on lib_names.csv will be current as of 2020-06-01 for CRAN.
* Only lightgbm can vary its version because it will be installed not from CRAN but from github.
