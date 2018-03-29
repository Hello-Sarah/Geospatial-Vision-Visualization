This is a README file for CS513 HW1 MATLAB 2016b executables for Windows system
(For Linux/Mac OS, you will need to configure the "\" seperator to "/" or proper one of your OS)

There are three methods which are located in three different folders:
	/Method_1/
	/Method_2/
	/Method_3/

Each method has a similiar way to execute:

1) inside each Method folder, there are three MATLAB ".m" files:
	base.m
	SmearDetector.m
	labelling.m
	
2) To run the medthods, you need to configure the "base.m" file:
	open the "base.m" file
	configure the variable "Path" to where the data "sample_drive" is located in your computer
	run "base.m" will run all data inside the "sample_drive"
	
3) If you do not like to run the entire data inside the "sample_drive":
	open the "SmearDetector.m" file
	change the variable "len" to a number of pictures you would like to run for each camera
	then run the "base.m"
	
4) Each method would automatically plots intermediate results and final results and save data into a ".mat" file and save figures into a ".fig" file for each camera.