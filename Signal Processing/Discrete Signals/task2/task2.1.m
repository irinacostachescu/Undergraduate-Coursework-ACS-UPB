load 'sunet_a.mat'
load 'sunet_i.mat'
load 'sunet_s.mat'
load 'xilo.mat'
[x1,f1] = auread('sunet_a');
[x2,f2] = auread('sunet_i');
[x3,f3] = auread('sunet_s');
[x4,f4] = auread('xilo');

% Durata este nr de esantionae inmultit cu perioada de esantionare
D1 = (1/f1) * length(x1);
D2 = (1/f2) * length(x2);
D3 = (1/f3) * length(x3);
D4 = (1/f4) * length(x4);
