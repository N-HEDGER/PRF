function im = noiseonf2(imsize,rms,factor)

im = im2double(randn(imsize,imsize)); % gaussian noise of correct size
ST.imagesize=min(size(im));
ST.rmsdesired=rms;
imfft = fft2(im); % Take fft of image.
imfft = fftshift(imfft); % Shift 0 frequency to the middle.
mag = abs(imfft); % Get magnitude
phase = angle(imfft); % and phase.

% Create two matrices, x and y. All elements of x have a value equal to its
% x coordinate relative to the centre, elements of y have values equal to
% their y coordinate relative to the centre. From these two matrices produce
% a radius matrix that gives distances from the middle

x = ones(ST.imagesize,1) * (-ST.imagesize/2 : (ST.imagesize/2 - 1));
y = (-ST.imagesize/2 : (ST.imagesize/2 - 1))' * ones(1,ST.imagesize);
radius = sqrt(x.^2 + y.^2); % Matrix values contain radius from centre.
radius(round(ST.imagesize/2+1),round(ST.imagesize/2+1)) = 1; % .. avoid division by zero.

filter = 1./(radius.^factor); % Construct the filter.

% Reconstruct fft of noise image, but now with the specified amplitude spectrum
%newfft = (mag .* filter) .* exp(i*phase);
newfft = filter .* exp(i*phase);
im = real(ifft2(fftshift(newfft))); % Invert to obtain final noise image

% imspect(im);

im = im-mean(im(:)); % ensure mean = 0

imrms = std(im(:));
rmsratio = ST.rmsdesired/imrms;
im = im*rmsratio*2; % multiply up to the desired rms contrast

% im = im/max(abs(im(:))); % scale from -1 to 1
% im = (im + 1)/2; % bump up to between 0 and 1

% imrms = std(im(:))
a = find(im>1); % clip values which are too large or small
im(a) = 1;
a = find(im<0);
im(a) = 0;

return