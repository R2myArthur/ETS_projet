% Le signal dure 4.14s
%[x,Fs] = audioread('furElise_TP.wav',[1,551]);
[x,Fs] = audioread('furElise_TP.wav');

% Ecouter le morceau à échantilloner
% soundsc(x,Fs);

% temps = 0:1/Fs:(length(x)-1)/Fs;
% 
% % Tracer la figure en fonction du temps
% figure;
% plot(temps,x);
% Tracer la tranformée de Fourier
% On trouve Nf avec le Théorème de Shanon 2^p
%freq = 0:Fs/Nf:(Nf-1)*Fs/Nf;

%plot(freq, abs(fft(x,Nf)));

freq = 0:Fs/Nf:(Nf-1)*Fs/Nf;
temps = 0:1/Fs:(length(x)-1)/Fs;

% Définir N : égale à la taille de x
notes = load('gamme.mat');
kmax = length(x) - 552;
Nf = 2^12;
S = zeros(Nf, kmax);
listes_notes = zeros(1, kmax);
%diff_notes =  zeros(1, length(notes));
for k = 1:kmax
    Z = x(k:k+551);
    S(:,k) =  (abs(fft(Z,Nf))).^2;
    [val_max,ind_max] = max(S(:,k));
%     for j=1:length(frequences_notes)
%         diff_notes(:,j) = abs(freq(ind_max) - frequences_notes(j));
%     end
    diff_notes = abs(freq(ind_max) - frequences_notes);
    
    [val_min, ind_min] = min(diff_notes);
    
    listes_notes(:,k) = frequences_notes(ind_min);
end

figure;
imagesc(temps, freq , log10(S));
hold on

temps_2 = 0:1/Fs:(kmax-1)/Fs;
plot(temps_2, listes_notes);
axis xy;
colorbar;

sig_synth = synthetise_musique(listes_notes, Fs);
% soundsc(x,Fs);
soundsc(sig_synth, Fs);

