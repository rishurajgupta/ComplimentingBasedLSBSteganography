%{
Encoding Process 
Step: 1 Read the Data
Step: 2 Read the Image
Step: 3	 For Every pixel of Image
	Step: 3.1 Read 3LSB’s i.e 2,3,4
	Step: 3.2 Read 3Bits of Data
	Step: 3.3 Get Complement of 3bits Data
	Step: 3.4 Compare 4LSB’s with Data Nibble and (Data Nibble)?
	Step: 3.5 Replace 4LSB’s with Nearest One i.e Data Nibble or (Data Nibble)?
	Step: 3.6 if Replacement bit are Data bits
			Replace 1LSB with 0
	Step: 3.7 else
			Replace 1LSB with 1
Step: 4 Write the Stego Image
%}

tic;
clc;
clear;
% file_name = 'lennag.png';
% file_name = 'lenna.png';
 file_name = 'Baboong.png';
% file_name = 'Baboon.png';
% file_name = 'ready.png';

binary = file2bin('text.txt')';
img =imread(file_name);
%img=img(1:6);
%disp(['Orignal =' dec2bin(img,8)]);
j=1;
MSB3 = bitshift(img,-5);
%disp(['MSB3 =' dec2bin(MSB3,3)]);
LSB4 = double(bitshift(img-bitshift(bitshift(img,-5),5),-1));%dec2bin(LSB3,3)
%disp(['LSB4 =' dec2bin(LSB4,4)]);
LSB_Dec = img-bitshift(bitshift(img,-1),1);
%disp(['LSB_Dec =' dec2bin(LSB_Dec,1)]);
for i=1:numel(img)
    %%disp(i);
    bits = binary(j:j+3);
    %disp(['bits =' bits]);
    j=j+4;
    bits_val = bin2dec(bits);
    bits_comp = 15-bits_val;
    %disp(['bits_comp =' dec2bin(bits_comp,4)]);
    if abs(LSB4(i)-bits_val) < abs(LSB4(i)-bits_comp)
        LSB4(i)=bits_val;
        LSB_Dec(i)=0;
    else
        LSB4(i)=bits_comp;
        LSB_Dec(i)=1;
    end  
end
LSB5 = bitshift(uint8(LSB4),1)+LSB_Dec;
%disp(['LSB5 =' dec2bin(LSB5,5)]);
SIMG = bitshift(MSB3,5)+LSB5;
%disp(['SIMG =' dec2bin(SIMG,8)]);
%dec2bin(SIMG,8)
imwrite(SIMG,['Stego_' file_name],'png');
subplot(1,2,1), imshow(img);title('Original Image');
subplot(1,2,2), imshow(SIMG);title('Stego Image');
toc;