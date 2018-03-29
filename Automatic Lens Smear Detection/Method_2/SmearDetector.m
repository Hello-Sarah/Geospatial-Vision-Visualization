% %function Smear Detector
function SmearDetector(imgDataPath,camera)
    % imgDataPath = 'C:\MATLABR2016a\bin\myworkspace\CS513\sample_drive\cam_0\';
    imgDataDir  = dir(imgDataPath);

    display('Start...');
    count = 1;
    len = length(imgDataDir);
%     len = 40;
    k = 0;
    R = zeros(2032,2032);
    G = zeros(2032,2032);
    B = zeros(2032,2032);
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
        R0 = I0(:,:,1);
        G0 = I0(:,:,2);
        B0 = I0(:,:,3);
        [RGmag, ~] = imgradient(R0);
        [GGmag, ~] = imgradient(G0);
        [BGmag, ~] = imgradient(B0);
        if k == 1
            preR = RGmag;
            preG = GGmag;
            preB = BGmag;
            continue;
        end
        Rtemp = abs(RGmag - preR);
        Gtemp = abs(GGmag - preG);
        Btemp = abs(BGmag - preB);

        R = imadd(R, Rtemp);
        G = imadd(G, Gtemp);
        B = imadd(B, Btemp);
        k = 0;
    end
    display('image reading done');

    R = R / floor(len/2);
    G = G / floor(len/2);
    B = B / floor(len/2);
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

    image = imbinarize(image,6);
    fig(5) = figure;
    imshow(image);
    title('Binarized image with threshold T = 6');

    save(sprintf('%s.mat', camera),'R','G','B','img','image');
    savefig(fig, sprintf('%s.fig', camera));
	labelling(imgDataPath);
end
