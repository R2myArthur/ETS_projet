% Génère un signal synthétique composé d'oscillations sinusoïdales de
% fréquences données en tout point d'un axe temporel

function [sig_synthetique,t] = synthetise_musique(tab_notes,Fs)

% tab_frequences : veteur contenant la liste des fréquences estimées en tout point de l'axe temporel
% Fs : frequence d'echantillonnage

N_signal = length(tab_notes);

% duree = 1/Fs*ones(N_signal,1); 
amp = ones(N_signal,1);


% Récupère la durée de chaque note (intervalles de temps où la fréquence
% estimée est la même)
ind_diff = find(diff(tab_notes)~=0);

N_notes = length(ind_diff);
freq_note = zeros(N_notes,1);
duree_note  = zeros(N_notes,1);

for k = 1:N_notes
    freq_note(k) = tab_notes(ind_diff(k));
    if k ==1
%         duree2(k) = sum(duree(1:ind_diff(k)));
         duree_note(k) = ind_diff(k)/Fs;
    else
%         duree2(k) = sum(duree(ind_diff(k-1)+1:ind_diff(k)));
        duree_note(k) = (ind_diff(k) - ind_diff(k-1))/Fs;%+1:ind_diff(k)));
    end
end

phase_last = 0;
t_last = 0;
sig_synthetique = [];

% Pour chaque note de fréquence freq_notes et de durée duree, synthétise un
% signal sinusoÏdal d'amplitude 1, en imposant la continuité de la phase à
% chaque transition.
for ii=1:N_notes
    t = 0:1/Fs:duree_note(ii);   
    sig_synthetique = [sig_synthetique ; amp(ii)*sin(2*pi*freq_note(ii)*(t-t_last-1/Fs) + phase_last)'];
    phase_last = 2*pi*freq_note(ii)*t(end);
    t_last = t(end);
end

N = length(sig_synthetique);
t = (0:N-1)/Fs;

% normalisation
sig_synthetique = sig_synthetique/max(abs(sig_synthetique));

