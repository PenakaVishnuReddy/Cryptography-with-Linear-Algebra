clc;clear;close all;

disp('***********************************************************************');
disp('*                           Cryptography                              *');
disp('***********************************************************************');

%Encryption

text=input('Enter The plain Text : ','s'); %Input for the plain text
n = input('Enter the key size : (Must be 4,9,....) : ');%Entering the key size
n=sqrt(n);
upperString=upper(text); %Converting the string to capital letters
charText=char(upperString); %Converting from string to char
Actualtext=charText-65; %Substracting 65 to obtain the letters in the range of 0-25
jk=Actualtext;

%Reshaping the text and making it as a matrix
if(rem(size(Actualtext),n)==[1 0])
    Message=reshape(Actualtext,n,length(Actualtext)/n);
    Message = [Message]';%Converting a row matrix to a matrix with n columns   
else
Actualtext=[Actualtext 25] ;%Adding an extra dummy character at the end 
    Message=reshape(Actualtext,n,length(Actualtext)/n);
    Message = [Message]';
end

%Now analysing the key and checking whether the key is fine or not
theKey=0;
for i=1:(n^2)
key=input('Enter the key: ');
theKey=[theKey key];
end
realkey=theKey(2:end);
rrealkey=realkey+65;
Key=char(rrealkey);
Actualkey=reshape(realkey,n,n)';

%Doing Encryption
if(det(Actualkey) ~= 0)%Checking whether key is invertible or not 
    Encmessage=Message*Actualkey;%Multiplying the plain text with the key
    Encmessage=mod(Encmessage,26);%Finding the mod of the multiplied matrix
    Encmessage=[Encmessage]';
    encmatrix=reshape(Encmessage,1,length(Actualtext));%Changing the matrix back to row matrix
    encmatrix=encmatrix+65;    
    Encrypted=char(encmatrix);
else
    disp(' The key matrix is not invertible ');
end

%Decryption

%Finding determinant of Key
    j=mod(det(Actualkey),26);
    for b = 1:26
        d(b)=j*b;
        h(b)=rem(d(b),26);
    end
   
%Finding [Det(key)]^-1  
    h=uint8(h);
    m=find(h==1);
    
%Finding inverse of Key by the formula : (key^-1) = [Det(key)]^-1 x Adj(key)    
    if(m ~=0)    
        invk=m.*adjoint(Actualkey);
    else
        disp('Enter Another Key');
        return;
    end
    
%Now decrypting the message
Encmessage=[Encmessage]';
decmsg=Encmessage*invk; %Multiplying inverse with the encrypted message
decmsg=mod(decmsg,26);
decmsg=[decmsg]';
decmsg=reshape(decmsg,1,length(Actualtext));
decmsg=decmsg+65;
if(rem(length(jk),n)==0)
    decmsg=uint8(decmsg);
    v=find(decmsg==91);
    decmsg(v)=65;
char(decmsg);
else
    decmsg=decmsg(1:length(Actualtext)-1);
    decmsg=uint8(decmsg);
    v=find(decmsg==91);
    decmsg(v)=65;
    char(decmsg);
end


