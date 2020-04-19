clc;
clearvars;
% ---------------------------ENCODING------------------------------%
input_len=input('enter the number of input bits: ');
%inp_len=500;   (reference value)
K=input('enter constraint length (K): ');
%K=3;           (reference value)
zer=zeros(1,K-1);                      % z is the matrix of zeros to be added

for i=1:input_len
    inp(i)=rand <0.5;
end

encoder_in=[zer,inp,zer]; % encoder_in is the encoded input with zeros
n=input('enter number of parity bits per window: ');
%n=2;           (reference value)
gen=zeros(n,K); % gen is a matrix which stores the generator polynomials

for i=1:n
g=input('enter generator polynomial: ','s');
o=char(num2cell(g));
o=reshape(str2num(o),1,[]);
       
         for j=1:K
         gen(i,j)=o(1,j);
         end
end

encoder_bits=zeros(1,n*(input_len+K-1));

for i=1:input_len+K-1
    for j=1:n
        for d=K:-1:1
            encoder_bits(1,j+(i-1)*n)=encoder_in(1,K-d+i)*gen(j,d) + encoder_bits(1,j+(i-1)*n);
        end
        encoder_bits(1,n*(i-1)+j)=mod(encoder_bits(1,n*(i-1)+j),2);
    end
end

display(encoder_bits); % enc_bits are the bits which are encoded
