function NOMS=extraire_noms(lignedenoms)

% NOMS=extraire_noms(lignedenoms)
%
% Version:     9.1 (2006)
% Langage:     Matlab    Version: 7.0
% Plate-forme: PC 
%
%___________________________________________________________________________
%
% Niveau de Validation : 3
%___________________________________________________________________________
%
% Description de la fonction : Fonction qui extrait les noms de marqueurs 
% dans une ligne d'en tete de
% fichier VICON : rq : les noms sont en majuscules et sont séparés par des
% virgules ex : 'MEXT,,,MINT,,,ATHT,,,'

%___________________________________________________________________________
%
% Paramètres d'entrée  : 
%
% lignedenoms : string ligne de noms de marqueurs séparés par des virgules
%
% Paramètres de sortie : 
%
% NOMS : liste de cellules contenant les noms de marqueurs
%___________________________________________________________________________
%
% Notes : 
%___________________________________________________________________________
%
% Fichiers, Fonctions ou Sous-Programmes associés 
%
% Appelants :
% extraire_donnees : fonction
%
%___________________________________________________________________________
%
% Mots clefs : extraction de noms dans une liste 
%___________________________________________________________________________
%
% Exemples d'utilisation de la fonction : 
% ligendenoms = 'MEXT,,,MINT,,,ATHT,,,'
% NOMS = {'MEXT','MINT','ATHT}
%___________________________________________________________________________
%
% Auteurs : H. Goujon
% Date de création : 06-07-05
% Créé dans le cadre de : Thèse
% Professeur responsable : F. Lavaste
%_________________________________________________________________________
%
% Laboratoire de Biomécanique LBM
% ENSAM C.E.R. de PARIS                          email: lbm@paris.ensam.fr
% 151, bld de l'Hôpital                          tel:   01.44.24.63.63
% 75013 PARIS                                    fax:   01.44.24.63.66
%___________________________________________________________________________
%
% Toutes copies ou diffusions de cette fonction ne peut être réalisée sans
% l'accord du LBM
%___________________________________________________________________________
%


reste=lignedenoms;
comp=1;

%separateur=virgule
if isempty(strfind(reste,';'))
    sep=',';
else
    sep=';';
end

% extraction des noms , 
while ~isempty(reste)
    [nom,reste]=strtok(reste,sep);
    NOMS{comp}=nom;
    comp=comp+1;
end

