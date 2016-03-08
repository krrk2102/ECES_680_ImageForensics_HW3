function coefficient = getDCTcoefficient(image, row, col)
% Input
%     image: input image for DCT dectection
%     row: row index of DCT subband
%     col: column index of DCT subband
% Return
%     coefficient: retrieved DCT coefficients

    % Initialize block size. 
    blockSize = 8;
    
    % Performing DCT by 8 * 8 block
    image = double(image) - 128;
    image = blkproc(image, [blockSize blockSize], 'dct2(x)');
    
    % Get corresponding DCT coefficients.
    coefficient = image(row : blockSize : end, col : blockSize : end);
    
    % Display the histogram.
    figure, histogram(coefficient, 'binmethod', 'integers');

end

