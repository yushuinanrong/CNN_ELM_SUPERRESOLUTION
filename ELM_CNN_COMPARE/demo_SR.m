% =========================================================================
% Test code for Super-Resolution Convolutional Neural Networks (SRCNN)
%
% Reference
%   Chao Dong, Chen Change Loy, Kaiming He, Xiaoou Tang. Learning a Deep Convolutional Network for Image Super-Resolution, 
%   in Proceedings of European Conference on Computer Vision (ECCV), 2014
%
%   Chao Dong, Chen Change Loy, Kaiming He, Xiaoou Tang. Image Super-Resolution Using Deep Convolutional Networks,
%   arXiv:1501.00092
%
% Chao Dong
% IE Department, The Chinese University of Hong Kong
% For any question, send email to ndc.forward@gmail.com
% =========================================================================

close all;
clear all;

%% read ground truth image
%im  = imread('Cell_HR\AC3_32.tif');

im = imread('AC2_8.tif');

%im  = imread('SRCNN\Set14\zebra.bmp');

%% set parameters
%up_scale = 3;
%model = 'SRCNN\model\9-5-5(ImageNet)\x3.mat';
%this is the previous model, I have change it
%so it can fit the 32*32 matrix
%up_scale = 3;
%model = 'model\9-3-5(ImageNet)\x3.mat';
% up_scale = 3;
% model = 'SRCNN\model\9-1-5(91 images)\x3.mat';
% up_scale = 2;
% model = 'SRCNN\model\9-5-5(ImageNet)\x2.mat'; 
up_scale = 4;
 model = 'model/9-1-5(91 images)/x4.mat';

%% work on illuminance only
% if size(im,3)>1
%     im = rgb2ycbcr(im);
%     im = im(:, :, 1);
% end
% im_gnd = modcrop(im, up_scale);
% im_gnd = single(im_gnd)/255;

%the if-end segment is used for the rgb picture, out picture
%is black - white, so we doesn't need it
%and the modcrop function has no effect, we only need to regular it
%that is divide by the integer 255
im_regular = single(im)/255;

%% bicubic interpolation
%im_l = imresize(im_gnd, 1/up_scale, 'bicubic');
%The foregoing sentence is used for turn 32*32 -> 8*8
%since we already is 8*8, so we don't need it
%the following are the algorithem we need
%that is bicubic the 8*8 picture firstly
%make it to be the 32*32
%im_b = imresize(im_l, up_scale, 'bicubic');
im_b = imresize(im_regular, up_scale, 'bicubic');



%% SRCNN
im_h = SRCNN(model, im_b);

%% remove border
im_h = shave(uint8(im_h * 255), [up_scale, up_scale]);
%im_gnd = shave(uint8(im_gnd * 255), [up_scale, up_scale]);
%we don't need the im_gnd, it is the 32*32 high resolution,
%and it is used to compare the super resolution to prove it even better
im_b = shave(uint8(im_b * 255), [up_scale, up_scale]);

%% compute PSNR
%psnr_bic = compute_psnr(im_gnd,im_b);
%psnr_srcnn = compute_psnr(im_gnd,im_h);
psnr_try=compute_psnr(im_b,im_h);

%% show results
%fprintf('PSNR for Bicubic Interpolation: %f dB\n', psnr_bic);
%fprintf('PSNR for SRCNN Reconstruction: %f dB\n', psnr_srcnn);
fprintf('PSNR for TRY Reconstruction: %f dB\n', psnr_try);

figure, imshow(im_b); title('Bicubic Interpolation');
figure, imshow(im_h); title('SRCNN Reconstruction');
%figure, imshow(im_gnd); title('im_gnd');

%I add the output of the privious 8*8
figure, imshow(im); title('The previous 8*8');

%imwrite(im_b, ['Bicubic Interpolation' '.bmp']);
%imwrite(im_h, ['SRCNN Reconstruction' '.bmp']);
