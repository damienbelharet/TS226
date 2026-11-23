function c = cc_encode(u, trellis)
% CC_ENCODE  Encodage convolutif avec fermeture du treillis.
%
%   c = cc_encode(u, trellis)
%
%   u       : vecteur de K bits du message (0 ou 1)
%   trellis : structure créée par poly2trellis (récursif ou non)
%   c       : mot de code, vecteur colonne de taille ns*(K+m)
%
%   L'encodeur part de l'état 0 et le treillis est fermé : après les K bits
%   du message, on ajoute m sections qui ramènent l'encodeur dans l'état 0.

    % --- Paramètres du code ---
    m  = log2(trellis.numStates);          % mémoire du code (nombre de registres)
    ns = log2(trellis.numOutputSymbols);   % nombre de bits de sortie par section
    K  = length(u);                        % nombre de bits du message
    L  = K + m;                            % nombre de sections, fermeture incluse

    c = zeros(ns*L, 1);                    % mot de code (colonne, comme u dans main.m)
    s = 0;                                 % état initial : tous les registres à 0

    for n = 1:L
        % 1) Choix du bit d'entrée b
        if n <= K
            b = u(n);                      % section "message" : on prend le bit du message
        else
            % Section de fermeture : on choisit l'entrée qui fait entrer un 0
            % dans les registres, c'est-à-dire celle dont l'état suivant a
            % son bit de poids fort à 0 (état suivant < numStates/2).
            % Marche en non récursif (b = 0) comme en récursif (b dépend de s).
            if trellis.nextStates(s+1, 1) < trellis.numStates/2
                b = 0;
            else
                b = 1;
            end
        end

        % 2) Lecture de la sortie dans la table outputs (+1 : indexation Matlab)
        out = trellis.outputs(s+1, b+1);   % entier entre 0 et 2^ns - 1

        % 3) Conversion de l'entier en ns bits, poids fort en premier,
        %    puis écriture dans les positions de la section n
        c((n-1)*ns+1 : n*ns) = bitget(out, ns:-1:1);

        % 4) Passage à l'état suivant
        s = trellis.nextStates(s+1, b+1);
    end

    % Vérification : après la fermeture, l'encodeur doit être revenu en 0
    assert(s == 0, 'cc_encode : le treillis n''est pas fermé');
end