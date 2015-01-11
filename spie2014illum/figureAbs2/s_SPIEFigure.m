folder = pwd;
cd ~/scien/iset
isetPath(pwd)
cd ~/scien/L3
L3Path(pwd)
cd(folder);

clear all, clc, close all
s_initISET

lights = {{'Tungsten', 'D65'},{'Tungsten', 'D65', 'Fluorescent'},...
{'Fluorescent', 'D65'},{'Fluorescent', 'D65', 'Tungsten'}};% {'D65'},{'Fluorescent'},{'Tungsten'}
cfas = {'RGBW1','Bayer'};
scenes = {'Vegetables'}; % AsianFemaleWithFlowers Chart Vegetables
figure%('Visible','off')

for ns = 1:length(scenes)
    for nl = 1:length(lights)
        for nc = 1:length(cfas)
            
            scene = sceneFromFile([scenes{ns} '.mat'],'multispectral');
	    	% scene = sceneCreate('nature100');
            sz = sceneGet(scene,'size');
            lname = [lights{nl}{1},num2str(length(lights{nl}))];
            
            load(['../QTtraindata/data/L3camera_',cfas{nc},'_','D65','.mat'])
            cameraD65 = camera;
            load(['../QTtraindata/data/L3camera_',cfas{nc},'_',lname,'.mat'])
            
            cameraAlt = L3ModifyCameraFG(camera,cameraD65,1);
            
            [srgbResult, srgbIdeal, raw, cameraAlt, xyzIdeal, lrgbResult] = ...
                cameraComputesrgbNoCrop(cameraAlt, scene, 60, sz, [], ...
                1,0,lights{nl}{1});
            
            imagesc(srgbIdeal); axis off; axis equal; axis tight;
			saveas(gcf,['srgbI_',scenes{ns},'_',cfas{nc},'_',lname,'_opt',num2str(1),'.png'],'png');
            %export_fig(['srgbI_',scenes{ns},'_',cfas{nc},'_',lights{nl},'_opt',num2str(1),'.png'],'-png','-transparent');
            imagesc(srgbResult); axis off; axis equal; axis tight;
			saveas(gcf,['srgbR_',scenes{ns},'_',cfas{nc},'_',lname,'_opt',num2str(1),'.png'],'png');
            %export_fig(['srgbR_',scenes{ns},'_',cfas{nc},'_',lights{nl},'_opt',num2str(1),'.png'],'-png','-transparent');
            
            cameraAlt = L3ModifyCameraFG(camera,cameraD65,2);
            
            [srgbResult, srgbIdeal, raw, cameraAlt, xyzIdeal, lrgbResult] = ...
                cameraComputesrgbNoCrop(cameraAlt, scene, 60, sz, [], ...
                1,0,lights{nl}{1});
            
            imagesc(srgbIdeal); axis off; axis equal; axis tight;
			saveas(gcf,['srgbI_',scenes{ns},'_',cfas{nc},'_',lname,'_opt',num2str(2),'.png'],'png');
            %export_fig(['srgbI_',scenes{ns},'_',cfas{nc},'_',lights{nl},'_opt',num2str(2),'.png'],'-png','-transparent');
            imagesc(srgbResult); axis off; axis equal; axis tight;
			saveas(gcf,['srgbR_',scenes{ns},'_',cfas{nc},'_',lname,'_opt',num2str(2),'.png'],'png');
            %export_fig(['srgbR_',scenes{ns},'_',cfas{nc},'_',lights{nl},'_opt',num2str(2),'.png'],'-png','-transparent');
            
            cameraAlt = L3ModifyCameraFG(camera,cameraD65,3);
            
            [srgbResult, srgbIdeal, raw, cameraAlt, xyzIdeal, lrgbResult] = ...
                cameraComputesrgbNoCrop(cameraAlt, scene, 60, sz, [], ...
                1,0,lights{nl}{1});
            
            imagesc(srgbIdeal); axis off; axis equal; axis tight;
			saveas(gcf,['srgbI_',scenes{ns},'_',cfas{nc},'_',lname,'_opt',num2str(3),'.png'],'png');
            %export_fig(['srgbI_',scenes{ns},'_',cfas{nc},'_',lights{nl},'_opt',num2str(3),'.png'],'-png','-transparent');
            imagesc(srgbResult); axis off; axis equal; axis tight;
			saveas(gcf,['srgbR_',scenes{ns},'_',cfas{nc},'_',lname,'_opt',num2str(3),'.png'],'png');
            %export_fig(['srgbR_',scenes{ns},'_',cfas{nc},'_',lights{nl},'_opt',num2str(3),'.png'],'-png','-transparent');
            
            cameraAlt = L3ModifyCameraFG(camera,cameraD65,4);
            
            [srgbResult, srgbIdeal, raw, cameraAlt, xyzIdeal, lrgbResult] = ...
                cameraComputesrgbNoCrop(cameraAlt, scene, 60, sz, [], ...
                1,0,lights{nl}{1});
            
            imagesc(srgbIdeal); axis off; axis equal; axis tight;
			saveas(gcf,['srgbI_',scenes{ns},'_',cfas{nc},'_',lname,'_opt',num2str(4),'.png'],'png');
            %export_fig(['srgbI_',scenes{ns},'_',cfas{nc},'_',lights{nl},'_opt',num2str(4),'.png'],'-png','-transparent');
            imagesc(srgbResult); axis off; axis equal; axis tight;
			saveas(gcf,['srgbR_',scenes{ns},'_',cfas{nc},'_',lname,'_opt',num2str(4),'.png'],'png');
            %export_fig(['srgbR_',scenes{ns},'_',cfas{nc},'_',lights{nl},'_opt',num2str(4),'.png'],'-png','-transparent');
            
            
        end
    end
end
