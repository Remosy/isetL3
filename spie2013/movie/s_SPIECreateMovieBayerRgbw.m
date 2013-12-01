%% s_SPIECreateMovieBayerRgbw
%
% This script renders a movie comparing the rendered images from Bayer and
% RGBW camera for different light levels.
% 
%
%
% (c) Stanford VISTA Team

%% Start ISET
s_initISET

%% Save rendered images and video in a local server
dataroot = '/biac4/wandell/data/qytian/L3Project';
saveFolder = fullfile(dataroot, 'spie2013', 'movie_bayer_rgbw_tradeoff');

% If it doesn't exist, create the folder where files will be saved
if exist(saveFolder, 'dir')~=7
    mkdir(saveFolder)
end

%% Load cameras
load('L3camera_bayer.mat', 'camera');
L3camera_bayer = camera; 
load('L3camera_rgbw_tradeoff.mat', 'camera');
L3camera_rgbw_tradeoff = camera;

%% Load scene
loadScene = fullfile(dataroot, 'scene', 'AsianWoman_1.mat');
scene = sceneFromFile(loadScene, 'multispectral');
sz = sceneGet(scene, 'size');

%% Set up video 
saveMovie = 0;
if saveMovie
    fps = 15;
    writerObj = VideoWriter(fullfile(dataroot, 'movie_bayer_rgbw_tradeoff'), 'Motion JPEG AVI');
    writerObj.FrameRate = fps;
    writerObj.Quality = 95;
    open(writerObj);
end

%% Specify light levels 
luminances = [logspace(-2, 1, 100), 10:5:300];

%% Render images
if ~saveMovie
    satPercent_bayer = rendervideoframes(L3camera_bayer, scene, luminances, saveFolder);
    satPercent_rgbw_tradeoff = rendervideoframes(L3camera_rgbw_tradeoff, scene, luminances, saveFolder);
    saveFile = [saveFolder, 'satPercent'];
    save(saveFile, 'satPercent_bayer', 'satPercent_rgbw_tradeoff');
end

%% Render video
if saveMovie
    figure(1); clf;
    set(gcf, 'Color', 'k', 'Position', [100 100 1400 800]);
    
    for ii = 1 : length(luminances)
        meanLum = luminances(ii); 
        disp(meanLum)
        
        name = cameraGet(L3camera_bayer, 'name');
        loadFile = fullfile(saveFolder, [name '_srgbResult_' num2str(meanLum) '.png']);
        srgbResult_bayer = imread(loadFile);
        
        name = cameraGet(L3camera_rgbw_tradeoff, 'name');
        loadFile = fullfile(saveFolder, [name '_srgbResult_' num2str(meanLum) '.png']);
        srgbResult_rgbw_tradeoff = imread(loadFile);

        srgbResult = [srgbResult_bayer, zeros(sz(1), 50, 3), srgbResult_rgbw_tradeoff];
        imshow(srgbResult)

        h = text(300, 600, 'Bayer', 'FontSize', 25);
        set(h, 'Color', 'w');

        h = text(1000, 600, 'RGBW', 'FontSize', 25);
        set(h, 'Color', 'w');

        for barPos = [1, 34, 67, 100, 119, 139, 159]
            h = text((barPos-1) / length(luminances) * size(srgbResult, 2), 650, '|', 'FontSize', 25);
            set(h, 'Color', 'w');
        end
        
        h = text((ii-1) / length(luminances) * size(srgbResult, 2), 650, 'o', 'FontSize', 25);
        set(h, 'Color', 'w');
        
        h = text(1340, 630, [num2str(meanLum, 3) 'cd/m^2'], 'FontSize', 10);
        set(h, 'Color', 'w');

        F = getframe(1);
        writeVideo(writerObj, F);

        pause(0.1)
    end
    close(writerObj);
end