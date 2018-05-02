% Read 16x190 image containing 1x10 characters
I = imread('numbers-16x190.png');

% Save to txt file
dlmwrite('BRAM_16.list', O16, '')
