function [ output] = key_exp( key )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
%   performs the key expansion of AES encryption algorithm
%   Usage: output = key_exp(key)
%   input: key to be expanded
%   output: result of key expansion on inputted key
rcon = {
    '8d' '01' '02' '04' '08' '10' '20' '40' '80' '1b' '36' '6c' 'd8' 'ab' '4d' '9a'...
    '2f' '5e' 'bc' '63' 'c6' '97' '35' '6a' 'd4' 'b3' '7d' 'fa' 'ef' 'c5' '91' '39'...
    '72' 'e4' 'd3' 'bd' '61' 'c2' '9f' '25' '4a' '94' '33' '66' 'cc' '83' '1d' '3a'...
    '74' 'e8' 'cb' '8d' '01' '02' '04' '08' '10' '20' '40' '80' '1b' '36' '6c' 'd8'...
    'ab' '4d' '9a' '2f' '5e' 'bc' '63' 'c6' '97' '35' '6a' 'd4' 'b3' '7d' 'fa' 'ef'...
    'c5' '91' '39' '72' 'e4' 'd3' 'bd' '61' 'c2' '9f' '25' '4a' '94' '33' '66' 'cc'...
    '83' '1d' '3a' '74' 'e8' 'cb' '8d' '01' '02' '04' '08' '10' '20' '40' '80' '1b'...
    '36' '6c' 'd8' 'ab' '4d' '9a' '2f' '5e' 'bc' '63' 'c6' '97' '35' '6a' 'd4' 'b3'...
    '7d' 'fa' 'ef' 'c5' '91' '39' '72' 'e4' 'd3' 'bd' '61' 'c2' '9f' '25' '4a' '94'...
    '33' '66' 'cc' '83' '1d' '3a' '74' 'e8' 'cb' '8d' '01' '02' '04' '08' '10' '20'...
    '40' '80' '1b' '36' '6c' 'd8' 'ab' '4d' '9a' '2f' '5e' 'bc' '63' 'c6' '97' '35'...
    '6a' 'd4' 'b3' '7d' 'fa' 'ef' 'c5' '91' '39' '72' 'e4' 'd3' 'bd' '61' 'c2' '9f'...
    '25' '4a' '94' '33' '66' 'cc' '83' '1d' '3a' '74' 'e8' 'cb' '8d' '01' '02' '04'...
    '08' '10' '20' '40' '80' '1b' '36' '6c' 'd8' 'ab' '4d' '9a' '2f' '5e' 'bc' '63'...
    'c6' '97' '35' '6a' 'd4' 'b3' '7d' 'fa' 'ef' 'c5' '91' '39' '72' 'e4' 'd3' 'bd'...
    '61' 'c2' '9f' '25' '4a' '94' '33' '66' 'cc' '83' '1d' '3a' '74' 'e8' 'cb' '8d'};

w = zeros(4,44);
rcon = double(hex2dec(rcon));

for i = 1:16
    w(i) = key(i);
end
a=2;
for i = 4:43
    temp = w(:,i);
    if (mod(i,4) == 0)
        temp = rotWord(temp);
%         disp('rotWord')
%         dec2hex(temp)
%       performing byte substitution
        temp = subByte(temp);
        temp = reshape(temp,1,4);
%         disp('subByte') 
%         dec2hex(temp)
%       inserting the rcon round constant
        temps = [rcon(a),0,0,0];
        temp = bitxor(temp,temps);
%         disp ('rcon') 
%         dec2hex(temp)
        a=a+1;
    end
    temp = reshape(temp,4,1);
    w(:,i+1)= bitxor((w(:,i-3)),temp);
end
% dec2hex(w)
% size(w)
output = w;
end

