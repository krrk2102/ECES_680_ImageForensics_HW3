function K = JPEGblockArtifact(image)
% Input
%     image: original image for detection
% Return
%     K: the strength of block artifacts

    image = int16(image);
    % Size information.
    [imgRow, imgCol] = size(image);
    % Enlarge image by 1 row and 1 column for Z'' calculation.
    image = [image image(:, 1); image(1, :) image(1, 1)];
    blockRow = floor(imgRow / 8);
    blockCol = floor(imgCol / 8);
    
    % Initialize Z' and Z'' matrix.
    Zp = uint8(zeros(blockRow, blockCol));
    Zpp = uint8(zeros(blockRow, blockCol));
    
    for i = 1 : blockRow
        for j = 1 : blockCol
            iBase = (i - 1) * 8 + 1;
            jBase = (j - 1) * 8 + 1;
            % Calculate Z' and Z'' element one by one.
            Zp(i, j) = abs( ...
                image(iBase+3, jBase+3) - image(iBase+3, jBase+4) - ...
                image(iBase+4, jBase+3) + image(iBase+4, jBase+4));
            Zpp(i, j) = abs( ...
                image(iBase+7, jBase+7) - image(iBase+7, jBase+8) - ...
                image(iBase+8, jBase+7) + image(iBase+8, jBase+8));
        end
    end
    
    % Get normalized histograms.
    HI = imhist(Zp);
    HI = HI ./ sum(HI);
    HII = imhist(Zpp);
    HII = HII ./ sum(HII);
    
    % Draw histograms.
    figure, plot(HI);
    hold, plot(HII);
    
    % Calculate strength.
    K = sum(abs(HI - HII));

end

