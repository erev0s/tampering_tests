*******************************************************************************
* Notice by Markos Zampoglou, ITI-CERTH, 2016: This is a redistribution of    *
* the code provided by the IAPP group in http://lesc.det.unifi.it/en/node/187 *
* The code has been modified by replacing "demo.m," adding "analyze.m" and    *
* the demo image, and removing the original demo script and images.           *
* Furthermore, jpeg_rec.m has been modified to include more complex cases of  *
* JPEG encodings.                                                             *
*******************************************************************************

Copyright (C) 2012 Tiziano Bianchi and Alessandro Piva,       
Dipartimento di Elettronica e Telecomunicazioni - Universit� di Firenze                        
via S. Marta 3 - I-50139 - Firenze, Italy                   

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.


Additional permission under GNU GPL version 3 section 7

If you modify this Program, or any covered work, by linking or combining it 
with Matlab JPEG Toolbox (or a modified version of that library), 
containing parts covered by the terms of Matlab JPEG Toolbox License, 
the licensors of this Program grant you additional permission to convey the 
resulting work. 


***************
* Description *
***************  
  
this archive includes a Matlab implementation of two algorithms used to 
detect and localize aligned and non-aligned double JPEG compression, as 
decribed in T.Bianchi, A.Piva, "Image Forgery Localization via Block-Grained 
Analysis of JPEG Artifacts",  IEEE Transactions on Information Forensics & 
Security, vol. 7,  no. 3,  June 2012,  pp. 1003 - 1017.  
 

************
* Platform *
************      

Matlab 7.4.0 (R2007a) (should work also on newer versions)


**************
*Environment *   
**************

tested on Windows XP x64 and Linux. 
Requires Matlab JPEG Toolbox available at: 
http://www.philsallee.com/jpegtbx/index.html

Matlab JPEG Toolbox is released under the following license:

"Copyright (c) 2003 The Regents of the University of California. 
All Rights Reserved. 

Permission to use, copy, modify, and distribute this software and its
documentation for educational, research and non-profit purposes,
without fee, and without a written agreement is hereby granted,
provided that the above copyright notice, this paragraph and the
following three paragraphs appear in all copies.

Permission to incorporate this software into commercial products may
be obtained by contacting the University of California.  Contact Jo Clare
Peterman, University of California, 428 Mrak Hall, Davis, CA, 95616.

This software program and documentation are copyrighted by The Regents
of the University of California. The software program and
documentation are supplied "as is", without any accompanying services
from The Regents. The Regents does not warrant that the operation of
the program will be uninterrupted or error-free. The end-user
understands that the program was developed for research purposes and
is advised not to rely exclusively on the program for any reason.

IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY
FOR DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES,
INCLUDING LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND
ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. THE UNIVERSITY OF
CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE. THE SOFTWARE PROVIDED HEREUNDER IS ON AN "AS IS"
BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATIONS TO PROVIDE
MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS."


************************
*Component Description *
************************

getJmap_EM.m: produces double compression likelihood map for A-DJPG
getJmapNA_EM.m: produces double compression likelihood map for NA-DJPG
EMperiod.m: implementation of proposed EM algorithm
h1periodDQ.m: compute pdf of doubly compressed DCT coeffs for A-DJPG
h1period.m: compute pdf of doubly compressed DCT coeffs for NA-DJPG
LLR.m: compute likelihood map according to simplified model    
jpeg_rec.m: simulates decompressed JPEG image from JPEG object
smooth_unshift.m: apply 3x3 mean filter and align likelihood map
floor2.m: modified floor function
ceil2.m: modified ceil function  
demo.m: demo script
README.txt: this file
gpl.txt: GPL license


***********************
* Set-up Instructions *  
***********************

extract all files to a single directory. Add the directory to the Matlab path, 
or set it as the current Matlab directory


********************
* Run Instructions *
********************      

open JPEG image using jpeg_read:

im = jpeg_read(<file_name>);

pass JPEG object to main function:

[map, map_s, q1, k1e, k2e] = getJmapNA_EM(im, 1, 6);

(use similar syntax for getJmap_EM)

the above parameters mean that tampering map(s) are obtained using only Y channel 
(ncomp = 1), DCT coefficients from 1 to 6 (zig-zag ordering).
The parameters for the EM algorithm are the same used in the TIFS paper.
map is computed using standard model, map_s is computed using simplified model.

map_final = smooth_unshift(sum(map,3), k1e, k2e);

final map is obtained by cumulating the likelihood maps of all DCT coeffs.
q1 is the estimated quantization matrix of first compression.
k1e, k2e is the estimated shift.

Run demo.m for more examples


**********************
* Output Description *
**********************

The algorithm returns a map giving the likelihood of being doubly JPEG compressed.
The algorithm also returns the estimated quantization matrix of first compression,
and the shift in the case of NA-DJPG. If double JPEG is not present map should be 
close to 0.5.


***********************
* Contact Information *
***********************

tiziano.bianchi@unifi.it
