% %function Smear Detector
function SmearDetector(imgDataPath,camera)
    % imgDataPath = 'C:\MATLABR2016a\bin\myworkspace\CS513\sample_drive\cam_0\';
    imgDataDir  = dir(imgDataPath);

    display('Start...');
    count = 1;
    len = length(imgDataDir);
    len = 50;
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
        I0 = uint32(imread(filename));
        R0 = I0(:,:,1);
        G0 = I0(:,:,2);
        B0 = I0(:,:,3);
        [RGmag, ~] = imgradient(R0);
        [GGmag, ~] = imgradient(G0);
        [BGmag, ~] = imgradient(B0);
        if k == 1
    %         I = I0;
            R = RGmag;
            G = GGmag;
            B = BGmag;
            continue;
        end
        R = imadd(R, RGmag);
        G = imadd(G, GGmag);
        B = imadd(B, BGmag);
    end
    display('image reading done');

    R = R / len;
    G = G / len;
    B = B / len;
    Im = cat(3,R,G,B);
    fig(1) = figure;
    imshow(uint8(Im),[]);
    title('RGB gradient magnitude image');

    img = (R + G + B) / 3;
    fig(2) = figure;
    imshow(img, []);
    title('Adding three channels into one channel image');

    h = ones(5,5) / 25;
    image = imfilter(img,h);
    fig(3) = figure;
    imshow(image,[]);
    title('Mean filtered image');

    fig(4) = figure;
    histogram(image);
    title('Histogram of the image');

    image = imbinarize(image,8.5);%segma = 13 for cam_3
    fig(5) = figure;
    imshow(image);
    title('Binarized image with threshold T = 6');

    save(sprintf('%s.mat', camera),'R','G','B','img','image');
    savefig(fig, sprintf('%s.fig', camera));
	labelling(imgDataPath);
end
