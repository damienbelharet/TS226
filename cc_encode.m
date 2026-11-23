function c = cc_encode(u, trellis)
% CC_ENCODE  Encodage convolutif avec fermeture du treillis
%   u       : vecteur de K bits du message
%   trellis : structure créée par poly2trellis
%   c       : mot de code de taille ns*(K+m)

% --- Paramètres du code ---
m  = log2(trellis.numStates);   % mémoire du code
ns = log2(trellis.numOutputSymbols);   % nombre de bits de sortie par section
K  = length(u);
L  = K+m;   % nombre de sections, fermeture incluse

c = zeros(ns*L, 1);   % mot de code (vecteur colonne, comme u dans main.m)
s = 0;                % état initial

for n = 1:L
    if n <= K
        b = u(n);
    else
        if trellis.nextStates(s+1, 1) < trellis.numStates/2
            b = 0;
        else
            b = 1;function c = cc_encode(u, trellis)
% CC_ENCODE  Encodage convolutif avec fermeture du treillis
%   u       : vecteur de K bits du message
%   trellis : structure créée par poly2trellis
%   c       : mot de code de taille ns*(K+m)

% --- Paramètres du code ---
m  = log2(trellis.numStates);   % mémoire du code
ns = log2(trellis.numOutputSymbols);   % nombre de bits de sortie par section
K  = length(u);
L  = K+m;   % nombre de sections, fermeture incluse

c = zeros(ns*L, 1);   % mot de code (vecteur colonne, comme u dans main.m)
s = 0;                % état initial

for n = 1:L
    if n <= K
        b = u(n);
    else
        if trellis.nextStates(s+1, 1) < trellis.numStates/2
            b = 0;
        else
            b = 1;
        end
    end
end

% Vérification : le treillis doit être fermé
assert(s == 0, 'Le treillis n''est pas fermé');
end
        end
    end
end

% Vérification : le treillis doit être fermé
assert(s == 0, 'Le treillis n''est pas fermé');
end