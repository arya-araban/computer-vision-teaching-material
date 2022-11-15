clear all;
close all;
clc;

%% Reading an image
a=imread('..\Images\2\Cameraman.bmp');

a=double(a);
%a = (a * 2) / max(a(:));
a = a + 128;
s=size(a);

%% Defingin points and calculating equation parameters
p1=[0,0];
p2=[150,20];
p3=[200,200];
p4=[255,255];
m1=(p1(1,2)-p2(1,2))/(p1(1,1)-p2(1,1));
m2=(p2(1,2)-p3(1,2))/(p2(1,1)-p3(1,1));
m3=(p3(1,2)-p4(1,2))/(p3(1,1)-p4(1,1));

c1=p1(1,2)-m1*p1(1,1);
c2=p2(1,2)-m2*p2(1,1);
c3=p3(1,2)-m3*p3(1,1);

%% Transformation function
t=[];
for x=0:255
    if(x<=p2(1,1))
        t=[t (m1*x+c1)];
    end
    if(x>p2(1,1) && x<=p3(1,1))
        t=[t (m2*x+c2)];
    end
    if(x>p3(1,1) && x<=p4(1,1))
        t=[t (m3*x+c3)];
    end
end


%% Getting output image
for n=1:s(1,1)
    for m=1:s(1,2)
        ot(n,m)=t(a(n,m)+1);
    end
end

plot(t)
grid on;
xlabel('Intensity in input image');
ylabel('Intensity in output image')
title('Piece-wise linear transformation : Contrast stretching function')


figure()
subplot(1,2,1)
imshow(a/255)
title('Original image')
subplot(1,2,2)
imshow(ot./255)     
title('Contrast stretching')