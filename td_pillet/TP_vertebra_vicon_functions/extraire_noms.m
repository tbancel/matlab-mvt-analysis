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
% fichier VICON : rq : les noms sont en majuscules et sont s�par�s par des
% virgules ex : 'MEXT,,,MINT,,,ATHT,,,'

%___________________________________________________________________________
%
% Param�tres d'entr�e  : 
%
% lignedenoms : string ligne de noms de marqueurs s�par�s par des virgules
%
% Param�tres de sortie : 
%
% NOMS : liste de cellules contenant les noms de marqueurs
%___________________________________________________________________________
%
% Notes : 
%___________________________________________________________________________
%
% Fichiers, Fonctions ou Sous-Programmes associ�s 
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
% Date de cr�ation : 06-07-05
% Cr�� dans le cadre de : Th�se
% Professeur responsable : F. Lavaste
%_________________________________________________________________________
%
% Laboratoire de Biom�canique LBM
% ENSAM C.E.R. de PARIS                          email: lbm@paris.ensam.fr
% 151, bld de l'H�pital                          tel:   01.44.24.63.63
% 75013 PARIS                                    fax:   01.44.24.63.66
%___________________________________________________________________________
%
% Toutes copies ou diffusions de cette fonction ne peut �tre r�alis�e sans
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

