clear;

for pic = 1 : 5
    image = imread(['DCTfprints' num2str(pic) '.tif']);
    coefficient = getDCTcoefficient(image, 2, 2);
end