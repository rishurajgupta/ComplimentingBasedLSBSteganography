function [binn]=file2bin(FileName)
% Read the file:
FID  = fopen(FileName, 'rb');
if FID < 0
   %error([ErrID, ':ReadFile'], ['Cannot read file: ', ClearFile]);
    msgbox(['Cannot read file: ', FileName],'File Error','Error');
end
Data = fread(FID, Inf, '*uint8');
Data2=Data(:);
bin=dec2bin(Data2,8)';
binn=bin(:);
fclose(FID);
end
