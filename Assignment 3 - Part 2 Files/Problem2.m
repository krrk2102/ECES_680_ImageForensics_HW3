clear;

K = zeros(1, 3);
for pic = 1 : 3
    image = imread(['blockArtifacts' num2str(pic) '.tif']);
    K(pic) = JPEGblockArtifact(image);
end