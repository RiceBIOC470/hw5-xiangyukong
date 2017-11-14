%HW5
%GB comments
%1a 70 No mask provided in repository. 
%1b 75 The final mask output only displays a fraction of the total cells. Your mask image appears to only capture the cells that were overlapped in your original mask. You need to create a new mask that incorporates your new watershed mask with the original mask.   
%1c 70 No mask provided. Can’t grade something that isn’t submitted when asked. 
%1d 75 Same problem as 1b. 
%2yeast: 10 Your script doesn’t import mask files. I had to replace your mask import function with a h5read function to properly import the mask. There is also very little effort to create well defined masks. 
%2worm: 10 same problem as 2yeast
%2bacteria: 10 same problem as 2yeast
%2phase: 10 same problem as 2yeast
%Overall: 41

% Note. You can use the code readIlastikFile.m provided in the repository to read the output from
% ilastik into MATLAB.

%% Problem 1. Starting with Ilastik

% Part 1. Use Ilastik to perform a segmentation of the image stemcells.tif
% in this folder. Be conservative about what you call background - i.e.
% don't mark something as background unless you are sure it is background.
% Output your mask into your repository. What is the main problem with your segmentation?  

% Cells in the up right corner are stacked therefore hard to separate.

% Part 2. Read you segmentation mask from Part 1 into MATLAB and use
% whatever methods you can to try to improve it. 

mask_con = ~readIlastikFile('stemcells_Simple Segmentation_conservative.h5');
con_improved = imclose(imopen(mask_con,strel('disk',3)),strel('disk',3));
CC_con = bwconncomp(con_improved);
stats_con = regionprops(CC_con,'Area');
area_con = [stats_con.Area];
fusedCandidates_con = area_con > mean(area_con) + std(area_con);
sublist_con = CC_con.PixelIdxList(fusedCandidates_con);
sublist_con = cat(1,sublist_con{:});
fused_con = false(size(mask_con));
fused_con(sublist_con) = 1;
imshow(fused_con,'InitialMagnification','fit');
nucmin_con = imerode(fused_con,strel('disk',11));
imshow(nucmin_con);
outside_con = ~imdilate(fused_con,strel('disk',1));
imshow(outside_con);
basin_con = imcomplement(bwdist(outside_con));
basin_con = imimposemin(basin_con,nucmin_con|outside_con);
pcolor(basin_con); shading flat;
L_con = watershed(basin_con);
imshow(L_con); colormap('jet'); caxis([0 2047]);

% Part 3. Redo part 1 but now be more aggresive in defining the background.
% Try your best to use ilastik to sep;arate cells that are touching. Output
% the resulting mask into the repository. What is the problem now?

% Some cells are shattered and cells in the gloomy area are not recognized.

% Part 4. Read your mask from Part 3 into MATLAB and try to improve
% it as best you can.

mask_agg = ~readIlastikFile('stemcells_Simple Segmentation_aggressive.h5');
agg_improved = imclose(imopen(mask_agg,strel('disk',3)),strel('disk',3));
CC_agg = bwconncomp(agg_improved);
stats_agg = regionprops(CC_agg,'Area');
area_agg = [stats_agg.Area];
fusedCandidates_con = area_agg > mean(area_agg) + std(area_agg);
sublist_agg = CC_con.PixelIdxList(fusedCandidates_agg);
sublist_agg = cat(1,sublist_agg{:});
fused_agg = false(size(mask_agg));
fused_agg(sublist_agg) = 1;
imshow(fused_agg,'InitialMagnification','fit');
nucmin_agg = imerode(fused_agg,strel('disk',11));
imshow(nucmin_agg);
outside_agg = ~imdilate(fused_agg,strel('disk',1));
imshow(outside_con);
basin_agg = imcomplement(bwdist(outside_conagg_con|outside_con));
pcolor(basin_agg); shading flat;
L_agg = watershed(basin_agg);
imshow(L_agg); colormap('jet'); caxis([0 2047]);

%% Problem 2. Segmentation problems.

% The folder segmentationData has 4 very different images. Use
% whatever tools you like to try to segement the objects the best you can. Put your code and
% output masks in the repository. If you use Ilastik as an intermediate
% step put the output from ilastik in your repository as well as an .h5
% file. Put code here that will allow for viewing of each image together
% with your final segmentation. 
seg_bacteria = ~readIlastikFile('bacteria_Simple Segmentation.h5');

seg_phase0 = ~readIlastikFile('cellPhaseContrast_Simple Segmentation1.h5');
seg_phase1 = imclose(imopen(seg_phase,strel('disk',5)),strel('disk',5));
seg_cell = ~readIlastikFile('cellPhaseContrast_Simple Segmentation0.h5');

seg_worm = ~readIlastikFile('worms_Simple Segmentation.h5');

seg_yeast = ~readIlastikFile('yeast_Simple Segmentation.h5');
