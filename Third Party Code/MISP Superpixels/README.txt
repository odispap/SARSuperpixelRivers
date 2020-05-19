/******************************************************************
*
*			Mixture-based Superpixel Segmentation			
*												
********************************************************************

/* Copyright 2016, Sertac Arisoy, Koray Kayabol

All Rights Reserved

Permission to use, copy, modify, and distribute this software and
its documentation for any non-commercial purpose is hereby granted
without fee, provided that the above copyright notice appear in
all copies and that both that copyright notice and this permission
notice appear in supporting documentation, and that the name of
the author not be used in advertising or publicity pertaining to
distribution of the software without specific, written prior
permission.

*/

/
*****************************************************************
* 			
*				General information
*	
********************************************************************

Thanks for your interest in our work. This is a MATLAB implementation 
for the Mixture-based Superpixel Segmentation algorithm. The 
theoretical detailed of the algorithm can be found in the following paper

Sertac Arisoy and Koray Kayabol, "Mixture-based superpixel 
segmentation and classification of SAR images", 
IEEE Geoscience and Remote Sensing Letters, vol.13, no. 11, 
pp. 1721-1725, 2016..
		  
If you use this software, you should cite
the aforementioned paper in any resulting publication.

If you have any questions about the code, please contact us.
Sertac Arisoy  via <sarisoy@gtu.edu.tr>, 
Koray Kayabol  via <koray.kayabol@gtu.edu.tr>.

In order to run demo code, cleanupregions, drawregionboundaries, regionadjacency 
and renumberregions functions are necessary. 
You can find these online available functions written by Peter Kovesi
at http://www.peterkovesi.com/projects/segmentation/


/*****************************************************************
* 			
*				      Usage						
*		
*******************************************************************


demo matlab code demonstrates of the usage of the code.
	
misp: compute the superpixel segmentation for a grayscale SAR image.
usage:
	[sMap] = misp(img,RegionSize);
	[sMap] = misp(img,RegionSize,alfa);

Input:
	img 		: grayscale SAR image
	RegionSize      : the starting size of the superpixels.
	alfa 	        : concentration parameter of the mixture  proportions (default = 1000000 )
	
Output:
	sMap 		 : raw superpixel map.
			
*/

