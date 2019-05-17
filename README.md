# Robust Data Modelling Using Thin Plate Splines

### Abstract

Using splines to model spatio-temporal data is one of the most common methods of data fitting used in a variety of computer vision applications. Despite its ubiquitous applications, particularly for volumetric image registration and interpolation, the existing estimation methods are still sensitive to the existence of noise and outliers. A method of robust data modelling using thin plate splines, based upon the well-known least K-th order statistical model fitting, is proposed and compared with the best available robust spline fitting techniques. Our experiments show that existing methods are not suitable for typical computer vision applications where outliers are structured (pseudo-outliers) while the proposed method performs well even when there are numerous pseudo-outliers.

## Running the code
* Run the script `main.m`

## Publication

If you find this work useful in your research, please consider citing:

	@INPROCEEDINGS{Tennakoon_2013_DICTA, 
	author={R. B. {Tennakoon} and A. {Bab-Hadiashar} and D. {Suter} and Z. {Cao}}, 
	booktitle={2013 International Conference on Digital Image Computing: Techniques and Applications (DICTA)}, 
	title={Robust Data Modelling Using Thin Plate Splines}, 
	year={2013}, 
	pages={1-8}, 
	doi={10.1109/DICTA.2013.6691522}, 
	month={Nov},}
