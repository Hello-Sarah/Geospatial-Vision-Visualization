% %function Smear Detector
function SmearDetector_New(imgDataPath,camera)
%     imgDataPath = 'C:\MATLABR2016a\bin\myworkspace\CS513\sample_drive\cam_0\';
    imgDataDir  = dir(imgDataPath);

    display('Start...');
    count = 1;
    len = length(imgDataDir);
%     len = 400;
    k = 0;
    for i = 1:len
        per = i/len;
        if per > 0.1*count
            display(count);
            count=count+1;
        end
    %     %     display(imgDataDir(i).name);
        %skip non-folders******************************************************
        if(isequal(imgDataDir(i).name,'.')||...
                isequal(imgDataDir(i).name,'..'))
            continue;
        end
        k = k + 1;
        %end skip non-folders**************************************************
    %     

        filename = [imgDataPath imgDataDir(i).name];
        I0 = double(imread(filename));
        if k == 1
            Imax = I0;
            Imin = I0;
            continue;
        end
        Imax = max(Imax, I0);
        Imin = min(Imin, I0);
    end
    display('image reading done');

    fig(1) = figure;
    subplot(1,2,1);
    imshow(uint8(Imax),[]);
    title('Imax image');
    subplot(1,2,2);
    imshow(uint8(Imin),[]);
    title('Imin image');

%     img3d_ = (Imax(:,:,1) + Imax(:,:,2) + Imax(:,:,3)) / 3 - (Imin(:,:,1) + Imin(:,:,2) + Imin(:,:,3)) / 3;
    
    img3d = Imax - Imin;
    img = max(img3d, [], 3);
    fig(2) = figure;
    imshow(img, []);
    title('Imax - Imin image');

    h = ones(5,5) / 25;
    image = imfilter(img,h);
    fig(3) = figure;
    imshow(image,[]);
    title('Mean filtered image');

    fig(4) = figure;
    histogram(image);
    title('Histogram of the image');

    image = imbinarize(image,190);
    fig(5) = figure;
    imshow(image);
    title('Binarized image');

    save(sprintf('%s.mat', camera),'Imax','Imin','img','image');
    savefig(fig, sprintf('%s.fig', camera));
	labelling(imgDataPath);
end
