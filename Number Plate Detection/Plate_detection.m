close all;
clear all;

im = imread('Number Plate Images/image6.png');
imgray = rgb2gray(im);
imbin = imbinarize(imgray);
im = edge(imgray, 'prewitt');

%Plakanın yerini bulmak için yazdığımız kod
Iprops=regionprops(im,'BoundingBox','Area', 'Image');
area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end    

im = imcrop(imbin, boundingBox);%Plaka alanını kırpan kod
im = bwareaopen(~im, 500); %Genişliği çok büyük olan veya 500'den küçük olan bazı nesneleri kaldırıyoruz

 [h, w] = size(im);%genişlik

imshow(im);

Iprops=regionprops(im,'BoundingBox','Area', 'Image'); %harfleri okuyan kod parçası
count = numel(Iprops);
noPlate=[]; %Plaka dizisi değişkeninin başlatıldığı kod parçası

for i=1:count
   ow = length(Iprops(i).Image(1,:));
   oh = length(Iprops(i).Image(:,1));
   if ow<(h/2) & oh>(h/3)
       letter=Letter_detection(Iprops(i).Image); %İkili görüntüye karşılık gelen harfi okuma
       noPlate=[noPlate letter] %Sonraki her karakteri noPlate değişkenine ekleme
   end
end