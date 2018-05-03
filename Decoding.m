%{
Decoding Process 
Step: 1 	Read the Stego Image
Step: 2	 For Every pixel of Image
	Step: 2.1 if decision bit is 0
3LSB’s i.e 2,3,4 is data nibble
	Step: 2.2 else
Complement of 3LSB’s i.e 2,3,4 is data nibble
Step: 3 write the secret Data to file
%}

tic;
clc;
clear;
% file_name = 'Stego_lennag.png';
% file_name = 'Stego_lenna.png';
 file_name = 'Stego_Baboong.png';
% file_name = 'Stego_Baboon.png';
 % file_name = 'Stego_ready.png';
dimg = imread(file_name);
dLSB4 = double(bitshift(dimg-bitshift(bitshift(dimg,-5),5),-1));%dec2bin(LSB3,3)
% dLSB3 = dLSB3(1:5)
% LSB3(1:5)
dLSB_Dec = dimg-bitshift(bitshift(dimg,-1),1);
% dLSB_Dec=dLSB_Dec(1:5)
% Val_Loc = find(dLSB_Dec==0);
Comp_Loc = find(dLSB_Dec==1);
dLSB4(Comp_Loc) = 15.-dLSB4(Comp_Loc);%dLSB3
dbin = dec2bin(dLSB4,4)';
dbinary = strcat(dbin(1:end));
bin2file(dbinary','ntext.txt');
toc;

